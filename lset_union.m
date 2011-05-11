function [phi] = lset_union(phi0, phi1)
% [PHI] = LSET_UNION(PHI)
% 
% Description
%     Compute the union of two level-set functions. This is equivalent to 
%     joining the interiors of both interfaces.
% 
% Inputs
%     PHI0, PHI1: 2-dimensional arrays.
%         Level-set functions.
%
% Outputs
%     PHI: 2-dimensional array.
%         The unioned level-set function.

phi = min(cat(3, phi0, phi1), [], 3);
