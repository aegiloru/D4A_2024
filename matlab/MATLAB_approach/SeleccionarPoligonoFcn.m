%% SeleccionarPoligonoFcn.m
% Permite al usuario definir interactivamente un polígono en un mapa geográfico, 
% almacenando las coordenadas seleccionadas y formateándolas para su uso en 
% aplicaciones de planificación de cobertura con UAVs

function [llapoints,xyzpoints] = SeleccionarPoligonoFcn(geoaxes,cacheLimitsLat,cacheLimitsLon,geocenter)

% Establecer titulo del grafico
title(["Dibujar Poligono de cobertura","Presione Enter para finalizar el dibujo del poligono"])

% Inicializar variables para el bucle de seleccion de poligono, listas
% vacias para almacenar latitudes y longitudes del poligono. Tambien
% inicializa la variable 'l' del objeto de linea del grafico
polygonSelectionLoop=true;
polyLats=[];
polyLons=[];
l=[];

% Bucle para capturar los puntos seleecionados por el usuario
% El bucle se rompe si el usuario presiona Enter
% Añade las coordenadas de cada punto seleccionado a las listas polyLats y
% polyLons.
% Dibuja cada punto seleccionado y conecta los puntos con lineas eliminando
% cualquier objeto de la linea anterior.
if(polygonSelectionLoop)
    while true
        % Define interactivamente el area de interes
        [city.Lat,city.Lon] = ginput(1);
        if isempty(city.Lat)
            break % El usuario presiono ENTER (no se capturo ninguna coordenada)
        else
            hold on;
            % Almacena las latitudes y longitudes en el eje geografico
            polyLats(end+1)=city.Lat;
            polyLons(end+1)=city.Lon;

            % Dibuja el punto seleccionado en el eje geografico
            geoplot(geoaxes,city.Lat, city.Lon, ...
                'Marker', 'o', ...
                'MarkerEdgeColor', 'k', ...
                'MarkerFaceColor', 'y', ...
                'MarkerSize', 3);
           
            % Elimina el objeto de linea anterior
            delete(l);

            % Dibuja las lineas que conectan los puntos del poligono
            l=geoplot([polyLats,polyLats(1)],[polyLons,polyLons(1)],'b');

            hold off;

            % Restaura los limites geografico a los valores almacenados
            geolimits(cacheLimitsLat,cacheLimitsLon);

        end
    end
end

% Formatea las coordenadas del UAV
llapoints=[[polyLats,polyLats(1)]',[polyLons,polyLons(1)]',...
    zeros(length(polyLats)+1,1)];
% Convierte a ENU (Este, Norte, Arriba)
xyzpoints= lla2enu(llapoints,geocenter,'flat');

%Elimina la tercera coordenada ya que el poligono es 2D.
xyzpoints(:,3)=[];
end

