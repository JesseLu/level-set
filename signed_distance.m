function [phi, err_hist] = signed_distance(phi, err_limit)
% [PHI, ERR_HIST] = SIGNED_DISTANCE(PHI, ERR_LIMIT)
%
% Description
%     Convert PHI to a signed distance function.
% 
% Inputs:
%     PHI: 2-dimensional array.
%         The level-set function.
% 
%     ERR_LIMIT: number.
%         The maximum tolerable error. The error is defined as,
%             norm(|grad phi| - 1) / num_grid_points,
%         which is basically the norm of the deviation of the absolute value
%         of the gradient from 1, divided by the number of grid points. 
% 
% Outputs:
%     PHI: 2-dimensional array.
%         The level set function, which should be closer to a signed distance
%         function.
% 
%     ERR: vector.
%         List of the error at every iteration of the algorithm. Use ERR(END) 
%         to access the final error. This should be less than ERR_LIMIT.



% Assume effectively unit-less grid resolution.
grid_spacing = 1.0;


    %
    % Compute the (smoothed) signed function S.
    %

S = phi ./ sqrt(phi.^2 + grid_spacing^2);


    %
    % Iterate until the error in the norm of the gradient is acceptable.
    %

dt = 0.5;
err_hist = [];

for k = 1 : 1e3
    norm_g = norm_gradient(phi, S);
    phi = phi - dt * S .* (norm_g - 1);

    % err = max(max(abs(norm_gradient(phi, S) - 1)));
    err = norm(norm_gradient(phi, S) - 1) / prod(size(phi));
    err_hist(end+1) = err;

    if (err < err_limit)
        return
    end
end


    %
    % If we get here, we did not complete successfully.
    %

subplot 131; lset_plot(phi);
subplot 132; imagesc(abs(norm_g'-1)); axis equal tight;
set(gca, 'Ydir', 'normal'); colorbar
subplot 133; semilogy(err_hist, '.-');
error('Could not achieve signed distance function.');



