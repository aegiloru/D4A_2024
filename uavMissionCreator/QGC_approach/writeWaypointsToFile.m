%%  writeWaypointsToFile.m
%
%   Escribe los waypoints y los puntos de despegue y aterrizaje en un archivo.
%   WAYPOINTS, TAKEOFF y LANDING deben estar en formato LLA (Latitud, Longitud, Altitud).
%   El archivo se guarda con el nombre especificado en FILENAME en formato ".txt"
%   o ".waypoints", dependiendo de la extensión del archivo, o asume un
%   valor por defecto default_waypoints.waypoints
%
%   MAVLINK EXPORT FORMAT:
%   <INDEX> <CURRENT WP> <COORD FRAME> <COMMAND> <PARAM1> <PARAM2> <PARAM3> <PARAM4> <PARAM5/X/LATITUDE> <PARAM6/Y/LONGITUDE> <PARAM7/Z/ALTITUDE> <AUTOCONTINUE>
%   https://mavlink.io/en/file_formats/
%   https://ardupilot.org/copter/docs/common-mavlink-mission-command-messages-mav_cmd.html#mav-cmd-nav-waypoint
%   Matlab: exportWaypointsPlan(cp,solnInfo,"misionLED.waypoints");


function writeWaypointsToFile(waypoints, filename, takeoff, landing)
      
    % Validar la entrada de waypoints, takeoff y landing
    validateattributes(waypoints, {'double'}, {'2d', 'nonempty','ncols', 3}, 'writeWaypointsToFile', 'waypoints');
    validateattributes(takeoff, {'double'}, {'vector', 'numel', 3}, 'writeWaypointsToFile', 'takeoff');
    validateattributes(landing, {'double'}, {'vector', 'numel', 3}, 'writeWaypointsToFile', 'landing');
    
    % Procesar el nombre del archivo
    [filepath, name, extension] = fileparts(filename);
    if isempty(extension)
        filename = 'default_waypoints.waypoints';
        % error('El archivo debe tener una extensión como .txt o .waypoints.');
    end
    
    % Abrir el archivo para escritura
    fileID = fopen(fullfile(filepath, [name, extension]), 'w');
    cleanup = onCleanup(@() fclose(fileID));  % Asegura el cierre del archivo
    
    % Escribir el encabezado
    fprintf(fileID, 'QGC WPL 110\n');
    
    % Escribir el punto de despegue
    MAV_CMD_NAV_TAKEOFF = 22;
    fprintf(fileID, '0\t1\t0\t%d\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t1\n', MAV_CMD_NAV_TAKEOFF, 0, 0, 0, 0, takeoff);
    
    % Escribir los waypoints
    MAV_CMD_NAV_WAYPOINT = 16;
    numWaypoints = size(waypoints, 1);
    missionWP = waypoints(:, 1:3);  % Los waypoints ya están en formato LLA
    
    % Crear el contenido del archivo para los waypoints
    fileContent = [(1:numWaypoints)', zeros(numWaypoints, 1), zeros(numWaypoints, 1), ...
                   repmat(MAV_CMD_NAV_WAYPOINT, numWaypoints, 1), zeros(numWaypoints, 1), zeros(numWaypoints, 1), ...
                   zeros(numWaypoints, 1), zeros(numWaypoints, 1), missionWP(:, 1:2), ...
                   missionWP(:, 3), ones(numWaypoints, 1)];
    
    % Escribir los waypoints en el archivo
    fprintf(fileID, '%u\t%u\t%u\t%u\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%u\n', fileContent');
    
    % Escribir el punto de aterrizaje
    MAV_CMD_NAV_LAND = 21;
    landContent = [numWaypoints+1, 0, 0, MAV_CMD_NAV_LAND, 0, 0, 0, 0, landing(1:2), landing(3), 1];
    fprintf(fileID, '%u\t%u\t%u\t%u\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%.9f\t%u\n', landContent');
    
    % Mostrar un mensaje indicando que el proceso ha finalizado
    fprintf('Proceso de escritura de waypoints en el archivo "%s" finalizado con éxito.\n', filename);

end