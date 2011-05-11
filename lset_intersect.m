function [phi] = lset_intersect(phi0, phi1)
% [PHI] = LSET_INTERSECT(PHI)
% 
% Description
%     Compute the intersection of two level-set functions. This is equivalent 
%     to joining the exteriors of both interfaces.
% 
% Inputs
%     PHI0, PHI1: 2-dimensional arrays.
%         Level-set functions.
%
% Outputs
%     PHI: 2-dimensional array.
%         The intersected level-set function.

phi = max(cat(3, phi0, phi1), [], 3);
