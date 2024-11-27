function plot_transects(polygon, transects)
    % Mostrar los transectos
    
    figure;
    hold on;
    plot(polygon(:, 1), polygon(:, 2), 'k', 'LineWidth', 2);
    for i = 1:length(transects)
        plot(transects{i}(:, 1), transects{i}(:, 2), 'r--');
    end
    hold off;
    axis equal;
    xlabel('X (m)');
    ylabel('Y (m)');
    title('Transectos de Vuelo');
    legend('Área de Cobertua', 'Transectos');
end
