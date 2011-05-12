% EXAMPLE1
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

phi = lset_circle([-10 0], 3);
phi = lset_union(phi, lset_circle([10 0], 3));
% phi = lset_intersect(phi, lset_complement(lset_circle([-40 0], 10)));
% phi = lset_intersect(phi, lset_complement(lset_circle([40 0], 20)));
% phi = lset_union(phi, lset_circle([40 0], 10));


    % 
    % Construct the signed distance function for the interface.
    %

[phi, err] = signed_distance(phi, 1e-1);


    % 
    % Construct a velocity field.
    %
a = 0;
V = lset_velfield(@(x, y) -(x+0.1).^-1 .* (abs(y)+1).^-1, @(x, y) 0.2*sign(y));


    %
    % Move the surface within the velocity field, keep phi "close" to a
    % signed distance function.
    %

while (true)
    lset_plot(phi); % Visualize.
    phi = update_interface(phi, V, 0); % Move the interface.
    [phi, err] = signed_distance(phi, 1e-3); % Make phi more sdf-like.
end


