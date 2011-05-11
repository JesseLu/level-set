function [A] = shift_array(A, shift)
% A = SHIFT_ARRAY(A, SHIFT)
%
% Description
%     Shift a 2-dimensional array with mirror boundary conditions. Used to
%     take derivatives in the level set methods.
% 
% Inputs
%     A: 2-dimensional array.
%         The array to be shifted.
% 
%     SHIFT: 2-element vector of integers.
%         SHIFT consists of [SX SY], where SX is the horizontal shift and SY 
%         is the vertical shift. Positive values shift downwards and to the 
%         right, while negative values shift upwards and to the left.
% 
% Outputs
%     A: 2-dimensional array.
%         The shifted array.


    %
    % Shift in the horizontal (x) direction.
    %

if (shift(1) > 0)
    A = [A(shift(1):-1:1,:); A(1:end-shift(1),:)];
elseif (shift(1) < 0)
    A = [A(-shift(1)+1:end,:); A(end:-1:end+shift(1)+1,:)];
end


    %
    % Shift in the vertical (y) direction.
    %

if (shift(2) > 0)
    A = [A(:,shift(2):-1:1), A(:,1:end-shift(2))];
elseif (shift(2) < 0)
    A = [A(:,-shift(2)+1:end), A(:,end:-1:end+shift(2)+1)];
end

