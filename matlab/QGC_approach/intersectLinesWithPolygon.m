function transects = intersectLinesWithPolygon(lines, polygon)
    % Intersección de líneas con un polígono
    transects = {};
    for i = 1:length(lines)
        line = lines{i};
        intersectedLine = intersectLinePolygon(line, polygon);
        if ~isempty(intersectedLine)
            transects{end+1} = intersectedLine;
        end
    end
end

function intersectedLine = intersectLinePolygon(line, polygon)
    % Intersección de una línea con un polígono (simplificada)
    intersectedLine = [];
    for i = 1:size(polygon,1)
        p1 = polygon(mod(i-1, size(polygon, 1)) + 1, :);
        p2 = polygon(mod(i, size(polygon, 1)) + 1, :);
        [xi, yi] = polyxpoly([line(1,1), line(2,1)], [line(1,2), line(2,2)], [p1(1), p2(1)], [p1(2), p2(2)]);
        if ~isempty(xi) && ~isempty(yi)
            intersectedLine = [intersectedLine; xi, yi];
        end
    end
end