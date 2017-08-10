function y = merged_mixed_lorenz_density(a,b,m,epsilon_1,epsilon_2)

% Numeric calculation of the merged lorenz density by adding weighted density
% functions in x direction.

y_min = min([(b/m) * a * epsilon_1 , (1-b)/(1-m) * a * epsilon_2]);

% Minimal y-value, such that there is an inverse value for one function

num_calc = 10000; 

% Number of points, where inverse of the density is calculated

%initialize grid and result array, which is in this case x_grid

y_grid = linspace(y_min,40,num_calc);
x_grid = zeros(1,num_calc);

for i = 1 : length(y_grid)
    x_grid(i) = m*find_inverse_value_density_merged(y_grid(i),a,epsilon_1,m,b) + (1-m)*find_inverse_value_density_merged(y_grid(i),a,epsilon_2,1-m,1-b);
end  
y = [x_grid;y_grid];
plot(x_grid,y_grid)
ylim([0 10])
grid on
end