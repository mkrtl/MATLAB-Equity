function [x_grid,y_grid] = merged_mixed_lorenz_density(a,b,m,epsilon_1,epsilon_2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Numeric calculation of the merged lorenz density of two countries by 
% adding weighted density functions in x direction. b is part of total 
% income of country 1. m is part of total population of party 1. 
% (1-b) , (1-m) consequently of country 2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Minimal y-value, such that there is an inverse value for one function

y_min = min([(b/m) * a * epsilon_1 , (1-b)/(1-m) * a * epsilon_2]);

% Number of points, where inverse of the density is calculated

num_calc = 10000; 

%initialize grid and result array, which is in this case x_grid
% Set maximal y value, that is of interest:

max_y_value = 40;

y_grid = linspace(y_min,max_y_value,num_calc);
x_grid = zeros(1,num_calc);

for i = 1 : length(y_grid)
    x_grid(i) = m*find_inverse_value_density_merged(y_grid(i),a,epsilon_1,m,b) + (1-m)*find_inverse_value_density_merged(y_grid(i),a,epsilon_2,1-m,1-b);
end

end