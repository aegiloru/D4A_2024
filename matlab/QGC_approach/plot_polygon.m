
%% plot_polygon.m

function plot_polygon(polygon, titulo)
    figure
    plot(polygon(:,1), polygon(:,2), 'k', 'LineWidth', 2);
    % axis equal;
    xlabel('X (m)');
    ylabel('Y (m)');
    title(titulo);
end
