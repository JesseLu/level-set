function [V] = lset_velfield(xfunc, yfunc)
% V = LSET_VELFIELD(XFUNC, YFUNC)
% 
% Description
%     Construct a velocity field in which to move the interface.
% 
% Inputs
%     XFUNC, YFUNC: function handles.
%         XFUNC and YFUNC are function handles that define the velocity field.
%         Both function handles must have two input parameters. These are for
%         the x- and y- position of the grid with respect to the grid center.
% 
% Outputs
%     V: structure.
%         V contains two fields, V.x and V.y, which define the velocity vector
%         on the grid.

global LSET_GRID
V.x = xfunc(LSET_GRID.x, LSET_GRID.y);
V.y = yfunc(LSET_GRID.x, LSET_GRID.y);
