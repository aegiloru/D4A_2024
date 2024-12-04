# Proyecto de Drones - Misión Autónoma

Este repositorio documenta los datos y análisis de un vuelo autónomo realizado con el dron **Holybro X500 V2**, utilizando PX4 y QGroundControl. Se incluyen detalles de la misión, análisis, y los datos crudos generados durante la operación.

---

## 📹 Videos de la misión

A continuación, se presentan los videos capturados durante la misión autónoma:

1. **Prueba de vuelo**  
   [![PRB-01-FligthTest](PRB-01-FligthTest.mp4)](PRB-01-FligthTest.mp4 "Haz clic para ver el video de la prueba de vuelo")

2. **Registro en QGroundControl**  
   [![PRB-01-QGC](PRB-01-QGC.mp4)](PRB-01-QGC.mp4 "Haz clic para ver el video del registro en QGC")

3. **Vista general**  
   [![PRB-01-UC](PRB-01-UC.mp4)](PRB-01-UC.mp4 "Haz clic para ver el video de la vista general")

> **Nota**: Dependiendo del navegador, los videos pueden reproducirse o descargarse.

---

## 📂 Estructura del repositorio

El directorio `PRB_01` contiene los siguientes archivos:

- `PRB-01-FligthTest.mp4`: Video del vuelo autónomo.
- `PRB-01-QGC.mp4`: Registro visual desde QGroundControl.
- `PRB-01-UC.mp4`: Video de la vista general de la misión.
- `log_13_2024-8-6-15-37-58.ulg`: Archivo de log crudo en formato `.ulg`.
- `log_13_2024-8-6-15-37-58.kml`: Archivo de log exportado para análisis en Google Earth.
- `Readme.MD`: Documento descriptivo de la misión.
- `.gitattributes`: Configuración de Git LFS para manejar archivos grandes.

---

## 📈 Análisis del vuelo

Un análisis detallado del vuelo está disponible en la herramienta [Flight Review](https://review.px4.io/plot_app?log=5086c7d8-113d-4358-868f-3d71cb6cbb9f), donde se pueden observar datos como:

- **Distancia recorrida**: 98.8 m.
- **Velocidad promedio**: 1.55 m/s (5.6 km/h).
- **Velocidad máxima**: 5.28 m/s (19.0 km/h).
- **Diferencia máxima de altitud**: 7 m.
- **Ángulo máximo de inclinación**: 22.9°.

---

## 🌍 Waypoints

### Tabla de Waypoints
| **Waypoint** | **Latitud**         | **Longitud**        | **Altitud (m)** |
|--------------|---------------------|---------------------|-----------------|
| WP-0 (HOME)  | 25° 19' 31.85" S   | 57° 38' 20.76" O    | 3               |
| WP-1         | 25° 19' 32.08" S   | 57° 38' 22.05" O    | 3               |
| WP-2         | 25° 19' 31.88" S   | 57° 38' 22.13" O    | 3               |

---

## 🛠️ Herramientas utilizadas

- **Hardware**: Holybro X500 V2
- **Software**: PX4 v1.14.3, NuttX v11.0.0
- **Análisis**: Flight Review, Google Earth Pro
- **Generación de trayectorias**:
  - MATLAB UAV Toolbox
  - SurveyComplexItem.cc (QGroundControl)

---

## 📧 Contacto

Si tienes alguna pregunta o sugerencia sobre este proyecto, no dudes en contactarme. 
