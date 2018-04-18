function y=find_inverse_value_density_mixed(value,a,epsilon) 

% Calculates the the value of the inverse of the Mixed Lorenz density with 
% paramter a at point value and a given epsilon value.

v = @(x) ((1-a) * (1/epsilon) * x.^((1/epsilon)-1) + a * epsilon * (1-x).^(epsilon-1))-value;
% Mixed Lorenz density minus value of interest
% Define maximal x-value of interest as v(1) = ininity and the algorithm
% fzero crashes in that case: 

max_x = 0.9999999;
y = fzero(v,[0,max_x]);
% Find root of Mixed Lorenz minus value, 
% which is exactly the value the mixed Lorenz density is equal to value of interest 
end

