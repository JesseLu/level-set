function [phi] = lset_box(pos, dim)
% [PHI] = LSET_BOX(POS, DIM)
% 
% Description
%     Level-set function for a box.
% 
% Inputs
%     POS: 2-element vector.
%         Center position of the box relative to the center of the grid.
%         In other words, POS = [0 0] will place the box at the center of the 
%         grid.
% 
%     DIM: 2-element vector.
%         Size of box. DIM = [width height].
% 
% Outputs
%     PHI: Level-set function implicitly describing a box.


Phi = lset_plane(pos-dim/2, [-1 0]);
phi = lset_intersect(phi, lset_plane(pos-dim/2, [0 -1]));
phi = lset_intersect(phi, lset_plane(pos+dim/2, [+1 0]));
phi = lset_intersect(phi, lset_plane(pos+dim/2, [0 +1]));


