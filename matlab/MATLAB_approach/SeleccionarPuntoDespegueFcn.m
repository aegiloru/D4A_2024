%% SeleccionarPuntoDespegueFcn.m
% Función para seleccionar interactivamente un punto de despegue en un eje geográfico

function [Lat,Lon] = SeleccionarPuntoDespegueFcn(geoaxes,cacheLimitsLat,cacheLimitsLon)    
    
    % Establecer titulo del grafico
    title("Seleccionar punto de despegue (Takeoff)")
    
    % Capturar la entrada del usuario
    [Lat,Lon] = ginput(1);
    
    % Mantener el grafico actual
    hold on;
    
    % Graficar el punto de despegue
    geoplot(geoaxes,Lat, Lon,'g*','MarkerSize',4);
    
    % Liberar el grafico actual
    hold off;
    
    % Restaurar los limites geografico
    geolimits(cacheLimitsLat,cacheLimitsLon);
end

