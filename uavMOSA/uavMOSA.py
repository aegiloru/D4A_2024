#!/usr/bin/env python3

import asyncio
from mavsdk import System
from mavsdk.mission import (MissionItem, MissionPlan)


def parse_qgc_wpl(file_path):
    """
    Analiza un archivo QGC WPL y devuelve una lista de objetos MissionItem.
    """
    mission_items = []
    with open(file_path, 'r') as file:
        lines = file.readlines()

        # Saltar la primera línea que contiene el encabezado
        for line in lines[1:]:
            parts = line.strip().split('\t')
            if len(parts) < 12:
                continue  # Omitir líneas inválidas

            # Extraer los campos necesarios
            lat = float(parts[8])  # Latitud
            lon = float(parts[9])  # Longitud
            alt = float(parts[10])  # Altitud
            autocontinue = bool(int(parts[11]))  # Auto-continue

            # Crear un objeto MissionItem
            mission_item = MissionItem(
                lat,
                lon,
                alt,
                3,  # Velocidad (asumimos un valor predeterminado)
                autocontinue,
                float('nan'),  # Sin inclinación específica de gimbal
                float('nan'),  # Sin orientación específica de gimbal
                MissionItem.CameraAction.NONE,  # Sin acción de cámara
                float('nan'),  # Radio de espera
                float('nan'),  # Radio de paso
                float('nan'),  # Yaw
                float('nan'),  # Sin ángulo de inclinación de cámara
                float('nan'),  # Sin ángulo de orientación de cámara
                MissionItem.VehicleAction.NONE  # Sin acción específica del vehículo
            )
            mission_items.append(mission_item)

    return mission_items


async def run():
    # Especificar la ruta al archivo QGC WPL
    qgc_wpl_file = "misionLED_V1_1.waypoints"

    print("Analizando el archivo de misión...")
    mission_items = parse_qgc_wpl(qgc_wpl_file)

    if not mission_items:
        print("No se encontraron elementos de misión válidos en el archivo.")
        return

    print(f"Se cargaron {len(mission_items)} elementos de misión.")

    drone = System()
    await drone.connect(system_address="udp://:14540")

    print("Esperando conexión con el dron...")
    async for state in drone.core.connection_state():
        if state.is_connected:
            print("-- ¡Dron conectado!")
            break

    mission_plan = MissionPlan(mission_items)

    await drone.mission.set_return_to_launch_after_mission(True)

    print("-- Subiendo el plan de vuelo")
    await drone.mission.upload_mission(mission_plan)

    print("Esperando estimación de posición global...")
    async for health in drone.telemetry.health():
        if health.is_global_position_ok and health.is_home_position_ok:
            print("-- Estimación de posición global OK")
            break

    print("-- Armando el dron")
    await drone.action.arm()

    print("-- Iniciando la misión")
    await drone.mission.start_mission()

    await asyncio.sleep(1)  # Dar tiempo para que inicie la misión


if __name__ == "__main__":
    asyncio.run(run())