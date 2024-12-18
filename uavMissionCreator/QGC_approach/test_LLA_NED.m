%% test_LLA_NED.m

%% Iniciliazar
clear variables
clc
close all

%% Datos de prueba para las coordenadas del polígono en LLA (Latitud, Longitud, Altitud)
lat = [-25.3253, -25.3256, -25.3257, -25.3254,-25.3253]';  % Latitudes de ejemplo
lon = [-57.6391, -57.6391, -57.6395, -57.6396,-57.6391]';  % Longitudes de ejemplo
alt = [3, 3, 3, 3, 3]';  % Altitud constante (en metros)

lla = [lat, lon, alt];
%lla0  = [-25.3253 -57.6391 0];
latlimits = [-25.3257611 -25.3246139]; % ROI-01 y R0I-02
lonlimits = [-57.6396222 -57.6386111];
geocenter = [mean(latlimits) mean(lonlimits) 0];

%% Graficar region de interes con coordenas LLA
fig1 = figure();
gax1 = geoaxes(fig1);
% Si esto funciona, intenta agregar el basemap
set(gax1, 'Basemap', 'satellite');
% Graficar los puntos que definen la region de interes (ROI)
geoplot(gax1,lla(:,1),lla(:,2),MarkerSize=25,Marker=".")
geolimits(latlimits,lonlimits);

%% Conversiond LLA a NED (posicionamiento local)
puntos = lla2ned(lla, geocenter, 'flat');
x = puntos(:,1,:);
y = puntos(:,2,:);
alt = puntos(:,3,:);
% Crear polígono
polygonPoints = [x, y];
% Graficar Poligono
figure
plot(polygonPoints(:,1), polygonPoints(:,2), 'k', 'LineWidth', 2);
% axis equal;
xlabel('X (m)');
ylabel('Y (m)');
title('Area de Cobertura');

%% Conversion de NED a LLA
altura = mean(alt);
% Agregar la tercera columna de altura
altura_columna = repmat(altura, size(polygonPoints, 1), 1);
polygonPoints = [polygonPoints, altura_columna];
% convertir a lla
lla_new = ned2lla(polygonPoints, geocenter, "flat");

%% Verificar si hay perdida de datos
% [lat, lon, alt] = [1 1 1] Por cada coordenada
lla_new == lla

%% Graficar region de interes con coordenas NED2LLA
fig2 = figure();
gax2 = geoaxes(fig2);
% Si esto funciona, intenta agregar el basemap
set(gax2, 'Basemap', 'satellite');
%Graficar los puntos que definen la region de interes (ROI)
geoplot(gax2,lla_new(:,1),lla_new(:,2),Marker="*")
geolimits(latlimits,lonlimits);

%%