function [phi] = update_interface(phi, V, a, b)
% PHI = UPDATE_INTERFACE(PHI, V, A, B)
% 
% Description
%     Update phi to reflect different types of interface motion:
%         * motion under an external velocity field,
%         * motion in the normal direction, and
%         * motion involving mean curvature.
% 
% Inputs
%     PHI: 2-dimensional array.
%         The level-set function.
% 
%     V: Structure.
%         Describes the velocity field.
% 
%     A: 2-dimensional array.
%         Coefficient for motion in the normal direction.
% 
%     B: Positive number.
%         Coefficient for motion involving mean curvature. Must be positive to
%         be stable.
% 
% Outputs
%     PHI: 2-dimensional array.
%         Updated level-set fuction.
        

    %
    % Obtain partial derivatives of phi.
    %

[dx, dy, dxx, dxy, dyy] = derivatives(phi);

    % 
    % Update phi, using upwind differencing.
    % Reference: Chapter 3 in Osher and Fedkiw, Level Set Methods
    % and Dynamic Implicit Surfaces (Springer 2003).
    %

% Compute the Hamiltonian for motion under an external velocity field, 
% choosing the upwind derivatives.
H_extvel = V.x .* ((V.x >= 0) .* dx.n + (V.x < 0) .* dx.p) + ...
    V.y .* ((V.y >= 0) .* dy.n + (V.y < 0) .* dy.p);

% Compute the Hamiltonian for motion in the normal direction.
H_normal = a .* norm_gradient(phi, a);

% Compute the curvature term, which is kappa * |grad phi|.
% In other words, equation 1.8 of Osher and Fedkiw, with one less power 
% in the denominator. 
k = (dx.o.^2 .* dyy - 2 * dx.o .* dy.o .* dxy + dy.o.^2 .* dxx) ./ ...
    (dx.o.^2 + dy.o.^2);

% Choose the time-step.
maxH = max(cat(3, abs(V.x(:)) + abs(V.y(:)), abs(H_normal(:))), [], 3);
dt = 0.9 / max(maxH(:) + 4*b);

% Update phi.
phi = phi - dt * ((H_extvel + H_normal) - b*k);
