function [phi] = draw_shapes(dims, s, varargin)
% PHI = DRAW_SHAPES(DIMS, S, [EDGE_LEN])
% 
% Description
%     Draw circles and rectangles. 
%
% Inputs
%     DIMS: 2-element vector.
%         Determines the size of the grid.
% 
%     PHI: Cell-array.
%         For rectangles, use [1 x_center y_center width height val].
%         For circles, use [0 x_center y_center radius val].
%         Here VAL should be -1 to insert and then +1 to subtract the shape.
% 
%     EDGE_LEN: Non-negative number (optional).
%         Smoothes the edges of the structure, default value is 1.0.
% 
% Outputs
%     S: 2-dimensional array.
%         Negative values are considered 'inside', positive values are
%         considered 'outside', and values equal to 0 are on the boundary.
    
if (isempty(varargin))
    edge_len = 1.0;
else
    edge_len = varargin{1};
end

% Get coordinates.
x = 1 : dims(1);
y = 1 : dims(2);
[x, y] = ndgrid (x, y);

center = [mean(x(:)), mean(y(:))];

phi = 1 * ones(dims);

% Draw the structures.
for cnt = 1 : length (s)
    if (s{cnt}(1) == 0) % draw circle       
        phi = my_draw_circle (center + s{cnt}(2:3), s{cnt}(4), s{cnt}(5), ...
            phi, x, y, edge_len);
    elseif (s{cnt}(1) == 1) % draw rectangle
        phi = my_draw_rectangle (center+s{cnt}(2:3) , s{cnt}(4:5), s{cnt}(6), ...
            phi, x, y, edge_len);
    else
        error ('could not determine what kind of structure to draw');
    end
end

% % Plot the structures.
% subplot 111; imagesc(phi'); axis equal tight; set(gca, 'Ydir', 'normal');

% Draw a rectangle.
function [S] = my_draw_rectangle (center, width, val, S, x, y, edge_length)

xy = {x, y};
for cnt = 1 : 2
    weight{cnt} = (width(cnt)/2 - abs (xy{cnt}-center(cnt)))./edge_length + 1/2;
    weight{cnt} = weight{cnt} .* (weight{cnt} > 0); % bottom caps at 0
    weight{cnt} = (weight{cnt}-1) .* (weight{cnt} < 1) + 1; % top caps at 1
end
w = weight{1}.*weight{2};
S = S .* (1-w) + val .* w;


% Draw a circle.
function [S] = my_draw_circle (center, radius, val, S, x, y, edge_length)

r = sqrt ((x-center(1)).^2 + (y - center(2)).^2);

weight = (radius - r)./edge_length + 1/2;
weight = weight .* (weight > 0); % bottom caps at 0
weight = (weight-1) .* (weight < 1) + 1; % top caps at 1

w = weight;
S = S .* (1-w) + val .* w;




