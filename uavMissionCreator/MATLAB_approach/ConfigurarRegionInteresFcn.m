%% ConfigurarRegionInteresFcn.m
% definir y guardar las coordenadas relevantes para una región de interés (ROI) para una misión de cobertura con un UAV (dron)
function [landLat, landLon, takeoffLat,takeoffLon,llapoints, xyzpoints] = ConfigurarRegionInteresFcn(geocenter, filename)
  
    % Verificar los argumentos de entrada
    if nargin < 2
        error('Debe proporcionar geocenter y filename.');
    end

    if length(geocenter) ~= 3
        error('geocenter debe ser un vector de 3 elementos [lat, lon, alt].');
    end

    % Coordenadas de aterrizaje
    landLat = -25.3254889;
    landLon = -57.6389917;
    
    % Coordenadas de despegue (takeoff)
    takeoffLat = -25.3253278;
    takeoffLon = -57.6389861;

    % Coordenadas geodesicas region de interes
    llapoints = [[-25.3257028 -57.6395167 0]; ...   % W01 - Waipoint 01
                [-25.3254333 -57.6395861 0]; ...    % W02
                [-25.3253556 -57.6391472 0]; ...    % W03
                [-25.3256056  -57.6390583 0]; ...   % W04
                [-25.3257028 -57.6395167 0]];       % W01
    % Coordenadas locales ENU - Easth, North, UP
    % Conversión de coordenadas geodesicas a locales ENU
    try
        xyzpoints = lla2enu(llapoints, geocenter, 'flat');
    catch ME
        error('Error al convertir coordenadas geodesicas a ENU: %s', ME.message);
    end

   % Guardar variables en un archivo solo si se proporciona filename
    if ~isempty(filename)
        try
            save(filename, 'landLat', 'landLon', 'takeoffLat', 'takeoffLon', 'llapoints', 'xyzpoints');
            fprintf('Datos guardados en %s\n', filename);
        catch ME
            error('Error al guardar el archivo: %s', ME.message);
        end
    end
end