%% Analisis del regristro de vuelo
% Modificado del codigo fuente de FlightReviw
% https://github.com/PX4/flight_review/blob/main/app/plot_app/configured_plots.py
% https://docs.px4.io/v1.12/en/config_mc/mc_jerk_limited_type_trajectory.html
% D4A-Analisis WP ULog

%% 1. Cargar archivo ULog

% Prb 01 - Vuelo a 3 waypoints
% ulogFile = 'log_13_2024-8-6-15-37-58.ulg';
% baseName = 'prueba_01';  % Nombre base para guardar los archivos

% Prb 02 - CPP generado por Matlab
% ulogFile = 'log_14_2024-8-6-15-44-48.ulg';
% baseName = 'prueba_02';     % Nombre base para guardar los archivos

% Prueba no valida
% ulogFile = 'log_15_2024-8-6-15-57-04.ulg';
% baseName = 'prueba_03';   % Nombre base para guardar los archivos

% Prb 04 - uavMOSA-SITL
ulogFile = 'log_1_2024-12-18-04-34-58.ulg';
baseName = 'prueba_04';  % Nombre base para guardar los archivos

ulogObj = ulogreader(ulogFile);



%% 2. Extraer Datos de Waypoints
waypointsData = readTopicMsgs(ulogObj, 'TopicName', 'position_setpoint_triplet');

% Coordenadas de los waypoints (current)
lat_wp = waypointsData.TopicMessages{1}.("current.lat"); % Latitud
lon_wp = waypointsData.TopicMessages{1}.("current.lon"); % Longitud
alt_wp = waypointsData.TopicMessages{1}.("current.alt"); % Altitud

wp_lla = [lat_wp, lon_wp, alt_wp]; % Matriz de latitud, longitud y altitud de los waypoints

%% 3. Extraer Datos de la Trayectoria GPS
gpsData = readTopicMsgs(ulogObj, 'TopicName', 'vehicle_global_position');

% Coordenadas GPS de la trayectoria
lat = gpsData.TopicMessages{1}.lat; % Latitud
lon = gpsData.TopicMessages{1}.lon; % Longitud
alt = gpsData.TopicMessages{1}.alt; % Altitud

%% 4. Calcular Error entre Waypoints y Trayectoria GPS
% Definir el radio de la Tierra en metros
R = 6371e3; % Radio de la Tierra en metros

% Función Haversine para calcular la distancia entre dos coordenadas
haversine = @(lat1, lon1, lat2, lon2) ...
    R * 2 * atan2(sqrt(sind((lat2 - lat1) / 2).^2 + ...
    cosd(lat1) .* cosd(lat2) .* sind((lon2 - lon1) / 2).^2), ...
    sqrt(1 - (sind((lat2 - lat1) / 2).^2 + ...
    cosd(lat1) .* cosd(lat2) .* sind((lon2 - lon1) / 2).^2)));

% Inicializar matriz para almacenar los errores
errors = zeros(length(lat_wp), 1);

% Calcular el error (distancia mínima) para cada waypoint
for i = 1:length(lat_wp)
    % Coordenadas del waypoint actual
    wp_lat = lat_wp(i);
    wp_lon = lon_wp(i);
    
    % Calcular distancia del waypoint a todos los puntos de la trayectoria
    distances = haversine(wp_lat, wp_lon, lat, lon);
    
    % Encontrar la distancia mínima
    errors(i) = min(distances);
end

%% 5. Mostrar Resultados
% Crear una tabla con los resultados
resultTable = table(lat_wp, lon_wp, alt_wp, errors, ...
    'VariableNames', {'Lat', 'Lon', 'Alt', 'Error_m'});

disp('Errores calculados para cada waypoint:');
disp(resultTable);

%% 6. Guardar Resultados
% Guardar la tabla como archivo CSV
csvFileName = [baseName, '_errors.csv'];
writetable(resultTable, csvFileName);
disp(['Resultados guardados en: ', csvFileName]);

% Guardar la tabla como archivo TXT
txtTableFileName = [baseName, '_errors.txt'];
fileID = fopen(txtTableFileName, 'w');
fprintf(fileID, 'Errores calculados para cada waypoint:\n');
fprintf(fileID, '%10s %10s %10s %10s\n', 'Lat', 'Lon', 'Alt', 'Error_m');
for i = 1:height(resultTable)
    fprintf(fileID, '%10.6f %10.6f %10.2f %10.6f\n', ...
        resultTable.Lat(i), resultTable.Lon(i), resultTable.Alt(i), resultTable.Error_m(i));
end
fclose(fileID);
disp(['Tabla de resultados guardada en: ', txtTableFileName]);

% Guardar los datos en un archivo MAT
mean_error = mean(errors);
std_error = std(errors);

matFileName = [baseName, '_data.mat'];
save(matFileName, 'lat', 'lon', 'alt', 'lat_wp', 'lon_wp', 'alt_wp', 'errors', 'resultTable', 'mean_error', 'std_error');
disp(['Datos guardados en: ', matFileName]);

% Guardar un archivo de texto con estadísticas
txtFileName = [baseName, '_stats.txt'];
fileID = fopen(txtFileName, 'w');
fprintf(fileID, 'Resumen de Errores:\n');
fprintf(fileID, 'Media del error: %.2f m\n', mean_error);
fprintf(fileID, 'Desviación estándar del error: %.2f m\n', std_error);
fclose(fileID);
disp(['Estadísticas guardadas en: ', txtFileName]);

%% 7. Graficar Trayectoria y Waypoints con Errores
figure;
geoplot(lat, lon, 'LineWidth', 1.5, 'DisplayName', 'Trayectoria GPS');
hold on;
geoscatter(lat_wp, lon_wp, 50, errors, 'filled', 'DisplayName', 'Waypoints (Errores)');
colorbar;
title('Trayectoria GPS y Waypoints con Errores');
legend;
hold off;

% Guardar la figura como imagen PNG
pngFileName = [baseName, '_plot.png'];
saveas(gcf, pngFileName);
disp(['Gráfico guardado en: ', pngFileName]);

%% Limpieza de datos si NaN
% Suponiendo que la tabla se llama resultTable
disp('Tabla original:');
disp(resultTable);

% Eliminar filas que contengan NaN
resultTableClean = rmmissing(resultTable);

disp('Tabla sin NaN:');
disp(resultTableClean);

% Calcular estadísticas sobre los errores
mean_error = mean(resultTableClean.Error_m);
std_error = std(resultTableClean.Error_m);

% Mostrar resultados estadísticos
disp(['Media del error (sin NaN): ', num2str(mean_error)]);
disp(['Desviación estándar del error (sin NaN): ', num2str(std_error)]);

% Guardar la tabla limpia en un archivo TXT
outputTableFile = [baseName, '_resultados_clean.txt'];
writetable(resultTableClean, outputTableFile, 'Delimiter', '\t');
disp(['Tabla limpia guardada en: ', outputTableFile]);

% Guardar las estadísticas en un archivo TXT
statsFile = [baseName, '_estadisticas.txt'];
fid = fopen(statsFile, 'w');
fprintf(fid, 'Media del error (sin NaN): %.6f\n', mean_error);
fprintf(fid, 'Desviación estándar del error (sin NaN): %.6f\n', std_error);
fclose(fid);
disp(['Estadísticas guardadas en: ', statsFile]);