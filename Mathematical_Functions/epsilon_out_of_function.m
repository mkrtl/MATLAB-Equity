function y = epsilon_out_of_function(x,y,a)

% This function calculates to a given pair of x and y values and a given a 
% the epsilon-value for this given input arguments. 
% As Mixed Lorenz Curves (MCL) do not intersect in the open interval (0,1)
% the epsilon-value is unique if existing. 
% It can be used to find out whether or not a curve is a MCL or not. 

f = @(epsilon) a* (1-(1-x).^epsilon) + (1-a) * x.^(1/epsilon) - y;
y = fzero(f,[0 1]);