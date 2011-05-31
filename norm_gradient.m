function [g] = norm_gradient(phi, a)
% G = NORM_GRADIENT(PHI, A)
% 
% Description
%     Calculate the norm of the gradient of level-set function PHI. Uses 
%     Godunov's scheme described in Sections 5.3.3 and 6.2 in Osher and 
%     Fedkiw, Level Set Methods and Dynamic Implicit Surfaces (Springer 2003).
% 
% Inputs
%     PHI: 2-dimensional array.
%         The level-set function.
% 
%     A: 2-dimensional array.
%         A weighting function which helps determine the upwinding direction.
% 
% Outputs
%     G: 2-dimensional array.
%         The norm of the gradient of PHI.

    %
    % Get the first derivatives of phi.
    %

[dx, dy] = derivatives(phi);


    %
    % Compute the gradient norm, using Godunov's scheme.
    % Reference: Sections 5.3.3 and 6.2 in Osher and Fedkiw, Level Set Methods
    % and Dynamic Implicit Surfaces (Springer 2003).
    %

phix2 = (a >= 0) .* ...
    max(cat(3, (dx.n.^2).* (dx.n > 0), (dx.p.^2) .* (dx.p < 0)), [], 3) + ...
    (a < 0) .* ...
    max(cat(3, (dx.n.^2).* (dx.n < 0), (dx.p.^2) .* (dx.p > 0)), [], 3);
phiy2 = (a >= 0) .* ...
    max(cat(3, (dy.n.^2).* (dy.n > 0), (dy.p.^2) .* (dy.p < 0)), [], 3) + ...
    (a < 0) .* ...
    max(cat(3, (dy.n.^2).* (dy.n < 0), (dy.p.^2) .* (dy.p > 0)), [], 3);

g = sqrt(phix2 + phiy2);


