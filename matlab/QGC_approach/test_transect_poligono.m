
% Definición del polígono de prueba (un cuadrado como ejemplo)

%% Inicializar
clear variables
clc
close all
%% ------------------ Prueba 1 -------------------------------------------
% Cuadrado
polygonPoints = [
    0, 0;
    10, 0;
    10, 10;
    0, 10
];
% Parámetros de entrada
gridAngle = 0; % Ángulo de la cuadrícula en grados
gridSpacing = 2; % Espaciado de la cuadrícula en metros

% Llamar a la función generateTransects
[transects, rotatedPolygon] = generateTransects(polygonPoints, gridAngle, gridSpacing);
transects_ori = intersectLinesWithPolygon(transects, polygonPoints);

% Función para visualizar los resultados
visualizeTransects(polygonPoints, rotatedPolygon, transects,transects_ori);
%% ------------------ Prueba 2 -------------------------------------------
% Triángulo Irregular
polygonPoints = [
    0, 0;
    15, 0;
    5, 10
];
% Parámetros de entrada
gridAngle = 45; % Ángulo de la cuadrícula en grados
gridSpacing = 2; % Espaciado de la cuadrícula en metros

% Llamar a la función generateTransects
[transects, rotatedPolygon] = generateTransects(polygonPoints, gridAngle, gridSpacing);
transects_ori = intersectLinesWithPolygon(transects, polygonPoints);

% Función para visualizar los resultados
visualizeTransects(polygonPoints, rotatedPolygon, transects,transects_ori);

%% ------------------ Prueba 3 -------------------------------------------
% Pentágono Irregular
polygonPoints = [
    2, 1;
    8, 0;
    12, 5;
    6, 8;
    1, 5
];
% Parámetros de entrada
gridAngle = 45; % Ángulo de la cuadrícula en grados
gridSpacing = 2; % Espaciado de la cuadrícula en metros

% Llamar a la función generateTransects
[transects, rotatedPolygon] = generateTransects(polygonPoints, gridAngle, gridSpacing);
transects_ori = intersectLinesWithPolygon(transects, polygonPoints);

% Función para visualizar los resultados
visualizeTransects(polygonPoints, rotatedPolygon, transects,transects_ori);

%% ------------------ Prueba 4 -------------------------------------------
% Hexágono Irregular
polygonPoints = [
    0, 0;
    10, 0;
    12, 5;
    8, 9;
    2, 9;
    -2, 5
];
% Parámetros de entrada
gridAngle = 45; % Ángulo de la cuadrícula en grados
gridSpacing = 2; % Espaciado de la cuadrícula en metros

% Llamar a la función generateTransects
[transects, rotatedPolygon] = generateTransects(polygonPoints, gridAngle, gridSpacing);
transects_ori = intersectLinesWithPolygon(transects, polygonPoints);

% Función para visualizar los resultados
visualizeTransects(polygonPoints, rotatedPolygon, transects,transects_ori);

%% ------------------ Prueba 5 -------------------------------------------
% Polígono Aleatorio Irregular
polygonPoints = [
    -5, -5;
    3, -7;
    8, 0;
    5, 7;
    -2, 5;
    -7, 3
];

% Parámetros de entrada
gridAngle = 78.6901; % Ángulo de la cuadrícula en grados
gridSpacing = 2; % Espaciado de la cuadrícula en metros

% Llamar a la función generateTransects
[transects, rotatedPolygon] = generateTransects(polygonPoints, gridAngle, gridSpacing);
transects_ori = intersectLinesWithPolygon(transects, polygonPoints);

% Función para visualizar los resultados
visualizeTransects(polygonPoints, rotatedPolygon, transects,transects_ori);

%% Segmento mas largo
a =[5 7]; a =[5 7];
% Ajuste lineal
p = polyfit(a, b, 1);

% La pendiente es el primer coeficiente
m = p(1)

% Calcular el ángulo en radianes
theta_rad = atan(m);

% Convertir el ángulo a grados
theta_deg = rad2deg(theta_rad)
