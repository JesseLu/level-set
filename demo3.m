% DEMO3 
%
% Description
%     Demonstrate interface movement in the normal direction.
%
%     Godunov's scheme is used to choose the most appropriate spatial
%     derivative. This is an attempt to correctly handle characteristics such
%     as the shock that forms where the two circles meet.

% Print out help message.
help demo3

    %
    % Initialize grid.
    %

lset_grid([160 160]);


    % 
    % Construct the initial structure/interface.
    %

phi = lset_circle([-35 0], 15);
phi = lset_union(phi, lset_circle([35 0], 15));


    % 
    % Construct the signed distance function for the interface.
    %

[phi, err] = signed_distance(phi, 1e-1);


    %
    % Move the surface within the velocity field, keep phi "close" to a
    % signed distance function.
    %

while (true)
    lset_plot(phi); drawnow; % Visualize.
    phi = update_interface(phi, [], 1, 0); % Move the interface.
    try
        [phi, err] = signed_distance(phi, 1e-3); % Make phi more sdf-like.
    catch
        lset_plot(phi); % Visualize.
        break; % If signed_distance failed, we have no more interfaces.
    end
end


