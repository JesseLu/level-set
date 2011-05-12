% EXAMPLE2
%
% Description
%     Move an interface in a clock-wise velocity field. Phi is kept relatively
%     close to a signed distance function.
% 
% Notes
%     There is quite a bit of noticeable error, in that the initial shape
%     changes considerably. This is expected in any rudimentary implementation
%     of the level set method. For a fix, see Chapter 9 in Osher and Fedkiw, 
%     Level Set Methods and Dynamic Implicit Surfaces (Springer 2003).

    %
    % Initialize grid.
    %

lset_grid([80 80]);


    % 
    % Construct the initial structure/interface.
    %

% phi = lset_circle([0 0], 60);
% phi = lset_intersect(phi, lset_complement(lset_box([-60 0], [80 20])));
% phi = lset_intersect(phi, lset_complement(lset_box([+60 0], [80 20])));
% phi = lset_intersect(phi, lset_complement(lset_circle([0 -60], 30)));
% phi = lset_intersect(phi, lset_complement(lset_circle([0 40], 20)));
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
    % Construct a velocity field.
    %

V = lset_velfield(@(x, y) 0*x, @(x, y) 0*y);


    %
    % Move the surface within the velocity field, keep phi "close" to a
    % signed distance function.
    %

while (true)
    subplot 121; lset_plot(phi); % Visualize.
    subplot 122; lset_plot(norm_gradient(phi, 0*phi+1));
    phi = update_interface(phi, V, 3); % Move the interface.
    [phi, err] = signed_distance(phi, 1e-3); % Make phi more sdf-like.
end


