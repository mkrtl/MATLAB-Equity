function y=find_inverse_value_density_merged(value,a,epsilon,m,b) 

%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates the value of the inverse of the Mixed Lorenz density with 
% weights m (equals weight of population) and b (equals weight of income) 
% with parameter a at point "value" and a given epsilon value. It is used to merge
% two Lorenz densities analytically in the function
% merged_mixed_lorenz_density.
%%%%%%%%%%%%%%%%%%%%%%%%%

% Weighted Lorenz density minus value of interest, such that root of
% function is the inverse of the density for given "value".

v = @(x) (b/m)*((1-a) * (1/epsilon) * x.^((1/epsilon)-1) + a * epsilon * (1-x).^(epsilon-1))-value;
if v(0) > 0 
    y = 0;
    % If there is no inverse value, as the function is bigger than the
    % value, return 0, such that the merged_mixed_lorenz_density is
    % calculated correctly. Note, that the lorenz density is monotonically
    % increasing. Therefore, v(0)>0 implies v(x) > 0 for all x > 0.

else
    % maximal x < 1 has to be defined, as v(1) = infinity and the algorithm
    % crashes in that case: 
    
    max_x = 0.99999999;
    
    y = fzero(v,[0,max_x]);
    
    % Calculate root of v(x) - value, which is exactly the x_0, 
    %where v(x_0) = value
end
end