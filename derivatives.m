function [dx, dy, dxx, dxy, dyy] = derivatives(phi)
% [DX, DY, [DXX, DXY, DYY]] = DERIVATIVES(PHI)
%
% Description   
%     Obtain the first and second partial derivatives of phi.
% 
% Inputs
%     PHI: 2-dimensional array.
%        Discretized function representing the boundary.
% 
% Outputs
%     DX, DY: 2-dimensional arrays.
%         First partial derivatives of PHI with mirror boundary conditions.
% 
%     DXX, DXY, DYY: 2-dimensional arrays (optional).
%         Second partial derivatives of PHI with mirror boundary conditions.


% Short-cut function to shift phi.
shift = @(s) shift_array(phi, -s);


    %
    % Obtain shifted versions of phi.
    %

xn = shift([-1 0]);
xp = shift([+1 0]);
yn = shift([0 -1]);
yp = shift([0 +1]);


    %
    % Compute all needed versions of the first derivatives.
    %

dx.p = xp - phi;
dx.o = 1/2 * (xp - xn);
dx.n = phi - xn;

dy.p = yp - phi;
dy.o = 1/2 * (yp - yn);
dy.n = phi - yn;


    %
    % Compute the second derivatives.
    %

if (nargout > 2) % Only if the user asks for them though.
    dxx = xp - 2*phi + xn;
    dyy = yp - 2*phi + yn;
    dxy = 1/4 * (shift([+1 +1]) - shift([+1 -1]) - ...
        shift([-1 +1]) + shift([-1 -1])); 
end
