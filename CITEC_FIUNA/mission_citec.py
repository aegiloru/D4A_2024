#!/usr/bin/env python3

import asyncio

from mavsdk import System
from mavsdk.mission import (MissionItem, MissionPlan)


async def run():
    drone = System()
    await drone.connect(system_address="udp://:14540")

    print("Esperando la conexion al drone...")
    async for state in drone.core.connection_state():
        if state.is_connected:
            print(f"-- Drone conectado!")
            break

    print_mission_progress_task = asyncio.ensure_future(
        print_mission_progress(drone))

    running_tasks = [print_mission_progress_task]
    termination_task = asyncio.ensure_future(
        observe_is_in_air(drone, running_tasks))

    mission_items = []
    #Punto 01
    mission_items.append(MissionItem(-25.2942278,
                                     -57.490408333333335,
                                     3,
                                     3,
                                     True,
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.CameraAction.NONE,
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.VehicleAction.NONE))
    #Punto 02
    mission_items.append(MissionItem(-25.2938389,
                                     -57.49028611111111,
                                     3,
                                     3,
                                     True,
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.CameraAction.NONE,
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.VehicleAction.NONE))
    #Punto 03
    mission_items.append(MissionItem(-25.2938278,
                                     -57.489850000000004,
                                     3,
                                     3,
                                     True,
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.CameraAction.NONE,
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),MissionItem.VehicleAction.NONE))

    #Punto 04
    mission_items.append(MissionItem(-25.2942028,
                                     -57.489891666666665,
                                     3,
                                     3,
                                     True,
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.CameraAction.NONE,
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),MissionItem.VehicleAction.NONE))
    
    #Punto 05
    mission_items.append(MissionItem(-25.2944306,
                                    -57.49010555555556,
                                     3,
                                     3,
                                     True,
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.CameraAction.NONE,
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     float('nan'),
                                     MissionItem.VehicleAction.NONE))

    mission_plan = MissionPlan(mission_items)

    await drone.mission.set_return_to_launch_after_mission(True)

    print("-- Actualizando el plan de vuelo (mision)")
    await drone.mission.upload_mission(mission_plan)

    print("Esperando a que el dron tenga una estimación de posición global...")
    async for health in drone.telemetry.health():
        if health.is_global_position_ok and health.is_home_position_ok:
            print("-- Estimación de posición global OK")
            break

    print("-- Armado")
    await drone.action.arm()

    print("-- Iniciando el plan de vuelo")
    await drone.mission.start_mission()

    await termination_task


async def print_mission_progress(drone):
    async for mission_progress in drone.mission.mission_progress():
        print(f"Progreso del plan de vuelo: "
              f"{mission_progress.current}/"
              f"{mission_progress.total}")


async def observe_is_in_air(drone, running_tasks):
    """ Monitors whether the drone is flying or not and
    returns after landing """

    was_in_air = False

    async for is_in_air in drone.telemetry.in_air():
        if is_in_air:
            was_in_air = is_in_air

        if was_in_air and not is_in_air:
            for task in running_tasks:
                task.cancel()
                try:
                    await task
                except asyncio.CancelledError:
                    pass
            await asyncio.get_event_loop().shutdown_asyncgens()

            return


if __name__ == "__main__":
    # Run the asyncio loop
    asyncio.run(run())
