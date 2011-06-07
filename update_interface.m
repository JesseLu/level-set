function [phi] = update_interface(phi, V, a, b, varargin)
% PHI = UPDATE_INTERFACE(PHI, V, A, B, ALPHA)
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
%         Describes the velocity field. If V = [], a zero-velocity field will
%         be used.
% 
%     A: 2-dimensional array.
%         Coefficient for motion in the normal direction.
% 
%     B: Non-negative number.
%         Coefficient for motion involving mean curvature. Must be positive to
%         be stable.
% 
%     ALPHA: Positive number (optional).
%         CFL coefficient for time step. Use 0 < ALPHA < 1 to ensure numerical
%         stability. Default value = 0.9.
% 
% Outputs
%     PHI: 2-dimensional array.
%         Updated level-set fuction.
        
% Determine alpha, the optional input parameter.
if isempty(varargin)
    alpha = 0.9;
else
    alpha = varargin{1};
end

% See if a velocity field was actually specified.
if isempty(V)
    V = struct('x', 0, 'y', 0);
end


    %
    % Obtain partial derivatives of phi.
    %

[dx, dy, dxx, dxy, dyy] = derivatives(phi);


    % 
    % Update phi, using upwind differencing.
    % Reference: Chapters 3, 4, and 6 in Osher and Fedkiw, Level Set Methods
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
k_denom = (dx.o.^2 + dy.o.^2);
k_denom(find(k_denom == 0)) = 1;
k = (dx.o.^2 .* dyy - 2 * dx.o .* dy.o .* dxy + dy.o.^2 .* dxx) ./ ...
    k_denom;
% k = (dx.o.^2 .* dyy - 2 * dx.o .* dy.o .* dxy + dy.o.^2 .* dxx) ./ ...
%     (dx.o.^2 + dy.o.^2);

% Choose the time-step.
nb = @(x) x(:) .* ((phi(:) >= -3) & (phi(:) <= 3));
maxH = max([abs(nb(V.x))+abs(nb(V.y)); abs(nb(H_normal))]);
dt = alpha / max(maxH + 4*b);

% Update phi.
phi = phi - dt * ((H_extvel + H_normal) - b*k);
