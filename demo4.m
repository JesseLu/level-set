% DEMO4 
%
% Description
%     "Fit" a contour, using motion normal to an interface.

% Print out help message.
help demo4
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

% Simple circle.
phi = lset_circle([-5 0], 15);


    % 
    % Construct the signed distance function for the interface.
    %

[phi, err] = signed_distance(phi, 1e-3);


    %
    % Move the surface within the velocity field, keep phi "close" to a
    % signed distance function.
    %

while (true)
    lset_plot(phi); % Visualize.
    hold on
    contour(phi0', [0 0], 'g-', 'LineWidth', 2);
    hold off
    drawnow
    phi = update_interface(phi, [], phi0, 0); % Move the interface.

%     % Use this update to add a significant amount of curvature motion, 
%     % this keeps the contour smooth.
%     phi = update_interface(phi, [], phi0, 10); % Move the interface.

    [phi, err] = signed_distance(phi, 1e-1); % Make phi more sdf-like.
end


