function [phi] = lset_circle(pos, radius)
% [PHI] = LSET_CIRCLE(POS, RADIUS)
% 
% Description
%     Level-set function for a circle.
% 
% Inputs
%     POS: 2-element vector.
%         Center position of the circle relative to the center of the grid.
%         In other words, POS = [0 0] will place the circle at the center 
%         of the grid.
% 
%     RADIUS: positive number.
%         Radius of circle. 
% 
% Outputs
%     PHI: Level-set function implicitly describing a circle.

global LSET_GRID
phi = sqrt((LSET_GRID.x-pos(1)).^2 + (LSET_GRID.y-pos(2)).^2) - radius;
