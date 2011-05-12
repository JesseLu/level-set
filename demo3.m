% DEMO3
%
% Description
%     Find the interface of a shape.
% 
%     Given a shape, this demo will attempt to use a level-set function under
%     an external velocity field to find the shape.
% 
%     Here, the shape is actually created using a level-set function, and the
%     velocity field is simply it's gradient.

% Print out help message.
help demo3

    %
    % Initialize grid.
    %

lset_grid([80 80]);


    % 
    % Construct the initial structure/interface.
    %

phi = lset_circle([10 0], 30);


    % 
    % Construct the signed distance function for the interface.
    %

[phi, err] = signed_distance(phi, 1e-1);


    % 
    % Construct the shape that we will attempt to find.
    %

theta = lset_circle([0 0], 30);


    % 
    % Construct a velocity field.
    %

[dx dy] = derivatives(theta);
V = lset_velfield(@(x, y) -dx.o, @(x, y) -dy.o);


    %
    % Move the surface within the velocity field, keep phi "close" to a
    % signed distance function.
    %

while (true)
    lset_plot(phi); % Visualize.
    phi = update_interface(phi, V, 0); % Move the interface.
    try
        [phi, err] = signed_distance(phi, 1e-3); % Make phi more sdf-like.
    catch
        lset_plot(phi); % Visualize.
        break; % If signed_distance failed, we have no more interfaces.
    end
end


