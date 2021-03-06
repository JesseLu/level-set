% DEMO5 
%
% Description
%     "Fit" a contour, using motion normal to an interface. Start with an 
%     initial "checker-board" level-set function.

% Print out help message.
help demo5
dims = [80 80];

    %
    % Form the contour that we will attempt to mimic.
    %

lset_grid(dims);
phi0 = lset_box([0 0], [30 10]);
phi0 = lset_union(phi0, lset_box([0 0], [10 30]));
[phi0, err] = signed_distance(phi0, 1e-1);


    %
    % Initialize grid.
    %

lset_grid(dims);


    % 
    % Construct the initial structure/interface.
    %

phi = lset_checkered;
[phi, err] = signed_distance(phi, 1e-1);


    %
    % Move the surface within the velocity field, keep phi "close" to a
    % signed distance function.
    %

for cnt = 1 : 50
    lset_plot(phi); % Visualize.
    hold on; contour(phi0', [0 0], 'g-', 'LineWidth', 2); hold off;
    drawnow

    phi = update_interface(phi, [], phi0, 0); % Move the interface.

    [phi, err] = signed_distance(phi, 1e-1); % Make phi more sdf-like.
end


