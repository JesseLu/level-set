function [phi] = update_interface(phi, V, b)

    %
    % Obtain partial derivatives of phi.
    %

[dx, dy, dxx, dxy, dyy] = derivatives(phi);

    % 
    % Update phi, using upwind differencing.
    % Reference: Chapter 3 in Osher and Fedkiw, Level Set Methods
    % and Dynamic Implicit Surfaces (Springer 2003).
    %

% Compute the Hamiltonian, choosing the upwind derivatives.
H = V.x .* ((V.x >= 0) .* dx.n + (V.x < 0) .* dx.p) + ...
    V.y .* ((V.y >= 0) .* dy.n + (V.y < 0) .* dy.p);

% Compute the curvature term, which is kappa * |grad phi|.
% In other words, equation 1.8 of Osher and Fedkiw, with one less power 
% in the denominator. 
k = (dx.o.^2 .* dyy - 2 * dx.o .* dy.o .* dxy + dy.o.^2 .* dxx) ./ ...
    (dx.o.^2 + dy.o.^2);

% Choose the time-step.
dt = 0.9 / max(abs(V.x(:)) + abs(V.y(:)) + 4*b);

% Update phi.
phi = phi - dt * (H - b*k);
