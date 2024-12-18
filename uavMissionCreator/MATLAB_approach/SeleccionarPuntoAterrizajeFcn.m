%% SeleccionarPuntoAterrizajeFcn.m
% Permite al usuario seleccionar interactivamente un punto de aterrizaje en 
% un mapa y muestra el punto seleccionado, asegurando que los límites del 
% gráfico se mantengan constantes y proporcionando una indicación visual 
% clara de la posición seleccionada

function [Lat,Lon] = SeleccionarPuntoAterrizajeFcn(geoaxes,cacheLimitsLat,cacheLimitsLon)
    % Establecer titulo del grafico
    title("Seleccionar posicion de aterrizaje")
    
    % Capturar la entrada del usuario
    [Lat,Lon] = ginput(1);
    
    hold on; % Mantener el grafico actual
    
    % Graficar el punto de aterrizaje
    geoplot(geoaxes,Lat, Lon,'r*','MarkerSize',4);

    hold off; % Liberar el grafico actual
    
    % Restaurar los limites geograficos
    geolimits(cacheLimitsLat,cacheLimitsLon);
    
    % Restablecer titulo del grafico
    title("Region de Cobertura")
end