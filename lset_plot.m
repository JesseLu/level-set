function lset_plot(phi)
% LSET_PLOT(PHI)
% 
% Description
%     Plot the 0-level set of PHI. Dark regions are considered "interior", while
%     light regions are considered "exterior".

% Plot the structures.
imagesc(phi', [-1 1]); 
colormap('gray');
axis equal tight; 
set(gca, 'Ydir', 'normal');
hold on;
contour(phi', [0 0], 'r-', 'LineWidth', 3);
hold off
drawnow;
