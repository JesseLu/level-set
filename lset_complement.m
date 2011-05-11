function [phi] = lset_complement(phi)
% [PHI] = LSET_COMPLEMENT(PHI)
% 
% Description
%     Produce the complement of an interface described by the level-set 
%     function PHI. This function reverses the "interior" and "exterior" spaces
%     defined by the interface.
% 
% Inputs
%     PHI: 2-dimensional array.
%         The level-set function to complement.
% 
% Outputs
%     PHI: 2-dimensional array.
%         The complemented level-set function.


phi = -phi;
