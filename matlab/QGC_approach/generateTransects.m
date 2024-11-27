function [transects, rotatedPolygon] = generateTransects(polygonPoints, gridAngle, gridSpacing)
    % Genera transectos dentro del área definida por polygonPoints
    % polygonPoints: Nx2 matriz de puntos (x, y)
    % gridAngle: Ángulo de la cuadrícula en grados
    % gridSpacing: Espaciado de la cuadrícula en metros

    %% Rotar el polígono para alinear con el ángulo de la cuadrícula
    theta = deg2rad(gridAngle);
    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    rotatedPolygon = (R * polygonPoints')';
    
    %% Calcular el bounding box del polígono rotado
    minX = min(rotatedPolygon(:,1));
    maxX = max(rotatedPolygon(:,1));
    minY = min(rotatedPolygon(:,2));
    maxY = max(rotatedPolygon(:,2));
    
    %% Generar líneas de transectos dentro del bounding box extendido
    transects = {};
    lines_x = (minX - 2*gridSpacing):gridSpacing:(maxX + 2*gridSpacing);
    for x = lines_x
        line = [x, minY - 2*gridSpacing; x, maxY + 2*gridSpacing];
        transects{end+1} = (R' * line')';
    end
    
    %% Intersección de líneas con el polígono
    %%transects = intersectLinesWithPolygon(transects, rotatedPolygon);
end

