function grid(dims)
% GRID(DIMS)
%
% Description
%     Initialize a grid in which to place shapes implicitly defined by a 
%     level-set function.
% 
% Inputs
%     DIMS: 2-element vector.
%         The size of the grid. DIMS = [width height].
% 
% Outputs
%     none. 

x = 1 : dims(1);
y = 1 : dims(2);
[x, y] = ndgrid (x, y);
center = [mean(x(:)), mean(y(:))];

global LSET_GRID
LSET_GRID = struct('x', x-center(1), 'y', y-center(2), ...
    'x_raw', x, 'y_raw', y, 'center', center, 'dims', dims);
