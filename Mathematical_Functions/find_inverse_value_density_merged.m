function y=find_inverse_value_density_merged(value,a,epsilon,m,b) 

% Calculates the the value of the inverse of the Mixed Lorenz density with weights m and b with 
% parameter a at point value and a given epsilon value. It is used to merge
% two Lorenz curves analytically.

v = @(x) (b/m)*((1-a) * (1/epsilon) * x.^((1/epsilon)-1) + a * epsilon * (1-x).^(epsilon-1))-value;
if v(0) >= 0 
    y = 0;
    % If there is no inverse value, as the function is bigger than the
    % value, return 0, such that the merged_mixed_lorenz_density is
    % calculated correctly

else
    y = fzero(v,[0,0.99999999]);
    
    % Calculate root of v(x) - value, which is exactly the x_0, 
    %where v(x_0) = value
end
end