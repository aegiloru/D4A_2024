%% GraficarDespegueROIAterrizaje.m
% Grafica los puntos de despegue, aterrizaje y los vértices de la región de interés en un mapa geográfico,
% añadiendo etiquetas descriptivas a cada uno de estos elementos para facilitar su identificación.
%
function GraficarDespegueROIAterrizaje(gax,tLat,tLon,lLat,lLon,llapoints)
    % Graficar el punto de despeque en el eje geografico
    geoplot(gax,tLat,tLon,LineWidth=2,MarkerSize=25,LineStyle="none",Marker=".")
    % Añadir una etiqueta de texto para el punto de despegue, ligeramente
    % desplazada
    text(gax,tLat+0.0025,tLon,"Takeoff",HorizontalAlignment="center",FontWeight="bold")

    % Graficar los puntos que definen la region de interes (ROI) en el eje
    % geografico
    geoplot(gax,llapoints(:,1),llapoints(:,2),MarkerSize=25,Marker=".")
    % Añadir una etiqueta de texto en el centro de la region de interes
    % (ROI) en el eje geografico
    text(gax,mean(llapoints(:,1)),mean(llapoints(:,2))+0.006,"ROI",HorizontalAlignment="center",Color="white",FontWeight="bold")

    % Graficar el punto de aterrizaje en el eje geografico
    geoplot(gax,lLat,lLon,LineWidth=2,MarkerSize=25,LineStyle="none",Marker=".")
    % Añadir una etiqueta de texto para el punto de aterrizaje, ligeramente
    % desplazada
    text(gax,lLat+0.0025,lLon,"Landing",HorizontalAlignment="center",FontWeight="bold")
end