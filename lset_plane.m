function [phi] = lset_plane(pos, n)
% [PHI] = LSET_PLANE(POS, N)
% 
% Description
%     Level-set function for a plane.
% 
% Inputs
%     POS: 2-element vector.
%         A point along the plane (line) relative to the center of the grid. 
%         For example, POS = [0 0] means that the plane will cut through the
%         center of the grid.
% 
%     N: 2-element vector.
%         Vector along normal of the plane. For example, N = [-1 1] will create
%         a plane cutting from the top-right to the bottom-left of the grid.
% 
% Outputs
%     PHI: Level-set function implicitly describing a plane.

global LSET_GRID
normal = n / norm(n);
phi = (LSET_GRID.x-pos(1)) .* n(1) + (LSET_GRID.y-pos(2)) .* n(2);
