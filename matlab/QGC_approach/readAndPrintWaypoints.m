% readAndPrintWaypoints.m
% Lee un archivo de waypoints y los imprime en forma tabular.

function readAndPrintWaypoints(filename)    
    % Abrir el archivo para lectura
    fileID = fopen(filename, 'r');
    if fileID == -1
        error('No se pudo abrir el archivo %s', filename);
    end
    
    % Inicializar una celda para almacenar los waypoints
    waypoints = {};
    
    % Leer el archivo línea por línea
    while ~feof(fileID)
        line = fgetl(fileID);
        
        % Ignorar el encabezado o líneas en blanco
        if startsWith(line, 'QGC WPL') || isempty(line)
            continue;
        end
        
        % Parsear la línea y extraer los datos
        data = sscanf(line, '%d\t%d\t%d\t%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%d');
        
        % Extraer los datos relevantes
        index = data(1);
        lat = data(9);
        lon = data(10);
        alt = data(11);
        command = data(4);
        
        % Agregar los datos a la celda de waypoints
        waypoints{end+1, 1} = index;
        waypoints{end, 2} = command;
        waypoints{end, 3} = lat;
        waypoints{end, 4} = lon;
        waypoints{end, 5} = alt;
    end
    
    % Cerrar el archivo
    fclose(fileID);
    
    % Imprimir los waypoints en formato tabular
    fprintf('\n%8s %12s %15s %15s %15s\n', 'Index', 'Command', 'Latitud', 'Longitud', 'Altitud');
    fprintf('%8s %12s %15s %15s %15s\n', '-----', '-------', '-------', '--------', '--------');
    for i = 1:size(waypoints, 1)
        fprintf('%8d %12d %15.6f %15.6f %15.2f\n', ...
            waypoints{i, 1}, waypoints{i, 2}, waypoints{i, 3}, waypoints{i, 4}, waypoints{i, 5});
    end
end