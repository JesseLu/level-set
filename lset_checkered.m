function [phi] = lset_checkered()
% [PHI] = LSET_CHECKERED
% 
% Description
%     Level-set function with near maximal boundary length. This is 
%     accomplished by poking holes of diameter 1 grid-point into the grid
%     in a checker-board pattern.
% 
% Inputs
%     None.
% 
% Outputs
%     PHI: Checker-board level-set function.

global LSET_GRID
phi = 1 / sqrt(8) * ...
    (2 * mod(LSET_GRID.x_raw, 2) - 1) .* (2 * mod(LSET_GRID.y_raw, 2) - 1);
