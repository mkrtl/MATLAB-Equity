function [x_grid,y_grid] = merged_lorenz_curve(a,b,m,epsilon_1,epsilon_2)
% Calculates the merged lorenz curve by integrating the merged lorenz
% density via the trapezoid rule. For calculation of merged lorenz density
% see merged_mixed_lorenz_density.

[x_grid_density,y_grid_density] = merged_mixed_lorenz_density(a,b,m,epsilon_1,epsilon_2); 
x_grid = x_grid_density;
y_grid = cumtrapz(x_grid_density,y_grid_density);
