function [p] = lset_phi2p(phi)

global LSET_GRID

lset_plot(phi)

% Get the contour.
c = contourc(phi, [0 0]);

% Delete the level-pairs headers (see contourc documentation).
ind = find(c(1,:) == 0);
c(:,ind) = [];
c = flipud(c);

% Helper arrays that will eventually be fused into p.
d = ones(LSET_GRID.dims);
d = {d, d, d, d};


rc = rem(c, 1);
x_int = find(rc(2,:) == 0);
y_int = find(rc(1,:) == 0);

% Shortcut function to access individual elements in the arrays.
s2i = @(i, j) sub2ind(LSET_GRID.dims, i, j);

% Mark distances to contour for grids adjacent to contour.
d{1}(s2i(floor(c(1,x_int)), c(2,x_int))) = rc(1,x_int); % Left.
d{2}(s2i(ceil(c(1,x_int)), c(2,x_int))) = 1 - rc(1,x_int); % Right.
d{3}(s2i(c(1,y_int), floor(c(2,y_int)))) = rc(2,y_int); % Bottom.
d{4}(s2i(c(1,y_int), ceil(c(2,y_int)))) = 1 - rc(2,y_int); % Top.

% Fuse distances together to get approximate nearest distance to contour.
my_cat = @(A, B) min(cat(3, A, B), [], 3);
d_x = my_cat(d{1}, d{2});
d_y = my_cat(d{3}, d{4});
% Diagonal fuse.
d_tot = ((d_x == 1) | (d_y == 1)) .* d_x .* d_y + ...
    ((d_x ~= 1) & (d_y ~= 1)) .* (d_x .* d_y) ./ sqrt(d_x.^2 + d_y.^2);
ind = find((d_x(:) == 0) | (d_y(:) == 0));
d_tot(ind) = 0;


p = d_tot .* (-1 * (phi < 0) + 1 * (phi > 0));
hold on
contour(p', [0 0], 'g-', 'LineWidth', 3);
hold off
