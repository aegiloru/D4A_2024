% Función de visualización
function visualizeTransects(polygon, rotatedPolygon, transects,transects_ori)
    figure;
    
    %% Polígono original
    subplot(1, 3, 1);
    fill(polygon(:,1), polygon(:,2), 'g', 'FaceAlpha', 0.3);
    hold on;
    plot(polygon(:,1), polygon(:,2), 'g');
    title('Polígono Original');
    axis equal;
    
    %% Polígono rotado y transectos
    subplot(1, 3, 2);
    fill(rotatedPolygon(:,1), rotatedPolygon(:,2), 'r', 'FaceAlpha', 0.3);
    hold on;
    plot(rotatedPolygon(:,1), rotatedPolygon(:,2), 'r');
    for i = 1:length(transects)
        line = transects{i};
        plot(line(:,1), line(:,2), 'b');
    end
    title('Polígono con Transectos');
    axis equal;

    %% Polígono rotado y transectos
    subplot(1, 3, 3);
    fill(polygon(:,1), polygon(:,2), 'r', 'FaceAlpha', 0.3);
    hold on;
    plot(polygon(:,1), polygon(:,2), 'r');
    for i = 1:length(transects_ori)
        line = transects_ori{i};
        plot(line(:,1), line(:,2), 'b');
    end
    title('Polígono Intercepcion Transectos');
    axis equal;
end