function [phi] = update_interface(phi, V)

    %
    % Obtain partial first derivatives of phi.
    %

[dx dy] = derivatives(phi);

    % 
    % Update phi, using upwind differencing.
    % Reference: Chapter 3 in Osher and Fedkiw, Level Set Methods
    % and Dynamic Implicit Surfaces (Springer 2003).
    %

% Compute the Hamiltonian, choosing the upwind derivatives.
H = V.x .* ((V.x >= 0) .* dx.n + (V.x < 0) .* dx.p) + ...
    V.y .* ((V.y >= 0) .* dy.n + (V.y < 0) .* dy.p);

% Choose the time-step.
dt = 0.9 / max(abs(V.x(:)) + abs(V.y(:)));

% Update phi.
phi = phi - dt * H;
