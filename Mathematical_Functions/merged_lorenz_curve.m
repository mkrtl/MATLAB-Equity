function y = merged_lorenz_curve(a,b,m,epsilon_1,epsilon_2)
% Calculates the merged lorenz curve by integrating the merged lorenz
% density via the trapezoid rule. For calculation of merged lorenz density
% see merged_mixed_lorenz_density.
A = merged_mixed_lorenz_density(a,b,m,epsilon_1,epsilon_2); 
y = [A(1,:);cumtrapz(A(1,:),A(2,:))];
plot (A(1,:),cumtrapz(A(1,:),A(2,:)))
axis( [0 1 0 1])
grid on