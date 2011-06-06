function [p] = lset_phi2p(phi)
% [P] = LSET_PHI2P(PHI)
%
% Description
%     Convert a level-set function into a smeared binary function representing
%     two distinct materials.
% 
% Input
%     PHI: 2D array.
%         The level-set function.
% Output
%     P: 2D array.
%         An array of numbers where -1 represents an interior material, +1
%         represents an exterior material, and values in-between are used to
%         allow a subgrid reolution of the boundary.

% Used to find the size of the level-set grid.
global LSET_GRID


    %
    % Get the contour.
    %

c = contourc(phi, [0 0]);

% Delete the level-pairs headers (see contourc documentation).
ind = find(c(1,:) == 0);
c(:,ind) = [];

% Put x-values on first row, and y-values on second row.
c = flipud(c);

    
    %
    % Find the x and y grid-intercepts.
    %

rc = rem(c, 1); % The remainder when divided by 1.
x_int = find(rc(2,:) == 0); % These points are x-intercepts.
y_int = find(rc(1,:) == 0); % These points are y-intercepts.


    %
    % Find approximate distance to contour for grid points adjacent to the
    % contour.
    %

% Helper arrays that will eventually be fused into p.
d = ones(LSET_GRID.dims);
d = {d, d, d, d};

% Shortcut function to access individual elements in the arrays.
s2i = @(i, j) sub2ind(LSET_GRID.dims, i, j);

% Mark distances to contour from left, right, top, and bottom.
d{1}(s2i(floor(c(1,x_int)), c(2,x_int))) = rc(1,x_int); % Left.
d{2}(s2i(ceil(c(1,x_int)), c(2,x_int))) = 1 - rc(1,x_int); % Right.
d{3}(s2i(c(1,y_int), floor(c(2,y_int)))) = rc(2,y_int); % Bottom.
d{4}(s2i(c(1,y_int), ceil(c(2,y_int)))) = 1 - rc(2,y_int); % Top.


    %
    % Fuse distances together to get approximate nearest distance to a contour.
    %

% Helper function to find element wise minimum of two 2D arrays.
my_cat = @(A, B) min(cat(3, A, B), [], 3);

% For points with contours directly above and below, or to the right and left, 
% use the distance to the closest contour.
d_x = my_cat(d{1}, d{2});
d_y = my_cat(d{3}, d{4});

% For points next to a contour in both the x- and y-directions, choose the 
% shortest length to the contour.
d_tot = ((d_x == 1) | (d_y == 1)) .* d_x .* d_y + ...
    ((d_x ~= 1) & (d_y ~= 1)) .* (d_x .* d_y) ./ sqrt(d_x.^2 + d_y.^2);

% Take care of the special case where the contour is directly on a grid point.
ind = find((d_x(:) == 0) | (d_y(:) == 0));
d_tot(ind) = 0;


    %
    % Produce p.
    %

p = d_tot .* (-1 * (phi < 0) + 1 * (phi > 0));

% % Graph result.
% lset_plot(phi)
% hold on
% contour(p', [0 0], 'g-', 'LineWidth', 3);
% hold off
