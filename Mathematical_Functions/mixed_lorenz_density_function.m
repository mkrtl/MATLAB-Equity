function y = mixed_lorenz_density_function(  epsilon_1,epsilon_2, a,x,m,b)

% Calculates value of mixed lorenz density at point x for given epsilon and
% a. Is used in merged_lorenz_curve_paper. Name of file is misleading as it
% is actually used to calculate the merged lorenz density.

y = @(x_1) (b/m)*((1-a)*(1/epsilon_1)*(x_1/m).^((1/epsilon_1)-1)+a*epsilon_1*(1-(x_1/m)).^(epsilon_1-1))-(1-b)/(1-m)*((1-a)*(1/epsilon_2)*((x-x_1)/(1-m)).^((1/epsilon_2)-1)+a*epsilon_2*(1-(x-x_1)/(1-m)).^(epsilon_2-1));

end
