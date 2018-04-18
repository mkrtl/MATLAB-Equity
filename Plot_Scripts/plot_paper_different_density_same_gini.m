% Different Lorenz Densities can have same Gini: 
gini = 0.4;
x_grid = 0:0.001:1;
example_data = [0.2,0.2,1.8,1.8];
example_x_values = [0,0.5,0.5,1]; 
epsilon = (1-gini)/(1+gini);
plot(example_x_values,example_data,'-o',x_grid,mixed_lorenz_density(x_grid,epsilon,0.6),'-')