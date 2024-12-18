#!/bin/bash
# Ejecutar en PX4_AUTOPILOT para levantar SITL
# make px4_sitl_default jmavsim

# Coordenadas de la FIUNA-CITEC
#echo "Establecindo las coordenadas FIUNA-CITEC"
#export PX4_HOME_LAT=-25.2945806
#echo "LAT: " $PX4_HOME_LAT
#export PX4_HOME_LON=-57.49041388888889
#echo "LON: " $PX4_HOME_LON

# Coordenadas de la UC-LED
echo "Establecindo las coordenadas FIUNA-LED"
export PX4_HOME_LAT=-25.3254642
echo "LAT: " $PX4_HOME_LAT
export PX4_HOME_LON=-57.639108
echo "LON: " $PX4_HOME_LON
export PX4_HOME_ALT=0
echo "LON: " $PX4_HOME_ALT
exit
