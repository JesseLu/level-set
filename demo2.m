% DEMO2 
%
% Description
%     Demonstrate interface movement under mean curvature. 
% 
%     The most curved surfaces shrink the fastest, while concave boundaries
%     actually grow outward. The disappearance of interfaces is demonstrated
%     as well.

% Print out help message.
help demo2

    %
    % Initialize grid.
    %

lset_grid([80 80]);


    % 
    % Construct the initial structure/interface.
    %

phi = lset_circle([0 0], 30);
phi = lset_intersect(phi, lset_complement(lset_circle([0 0], 27)));
phi = lset_union(phi, lset_circle([-10 0], 10));
phi = lset_union(phi, lset_circle([15 0], 10));
phi = lset_intersect(phi, lset_complement(lset_box([30 0], [78 4])));


    % 
    % Construct the signed distance function for the interface.
    %

[phi, err] = signed_distance(phi, 1e-1);


    % 
    % Construct a (zero) velocity field.
    %

V = lset_velfield(@(x, y) 0*x, @(x, y) 0*y);


    %
    % Move the surface by mean curvature, keep phi "roughly" a signed 
    % distance function.
    %

while (true)
    lset_plot(phi); % Visualize.
    phi = update_interface(phi, V, 0, 3); % Move the interface.
    try
        [phi, err] = signed_distance(phi, 1e-3); % Make phi more sdf-like.
    catch
        lset_plot(phi); % Visualize.
        break; % If signed_distance failed, we have no more interfaces.
    end
end


