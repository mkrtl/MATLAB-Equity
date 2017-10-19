function y = mixed_lorenz_density( x, epsilon, a)
% Calculates value of mixed lorenz density at point x for given epsilon and
% a. x can be vector.
y = ((1-a)*(1/epsilon)*x.^((1/epsilon)-1)+a*epsilon*(1-x).^(epsilon-1));
end
