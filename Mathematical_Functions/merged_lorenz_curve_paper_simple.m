function y = merged_lorenz_curve_paper_simple(m,b,epsilon_1,epsilon_2,a) 
% Calculates a merged lorenz curve according to paper " A straightforward
% calculus" by Professor Kämpke. Uses the simple algorithm
% "find_root_super_simple" for calculating the values of the deconvolution
% and is therefore more stable as merged_lorenz_curve_paper. 
 
% CAUTION: Curve is not really normalized, i.e. F(1-delta) < 1 for all delta > 0 usually.
% There is a nasty solution implemented by setting F(1) =1 
% F(1) can not be calculated by the strucure of the convolution.


% Initialize grid and result array

x_grid = linspace(0,1,1000);
% Calculation towards 1 become difficult. Therefore, they're left out.
result = zeros(1,length(x_grid));



% Now calculate x_l

if (1-b)/(1-m)* epsilon_2 *a <= b/m * epsilon_1 * a
    g = @(x) (1-b)/(1-m) *((1-a)*(1/epsilon_2)*x.^((1/epsilon_2)-1)+a*epsilon_2*(1-x).^(epsilon_2-1)) - a*(b/m)*epsilon_1;
    x_l =  (1-m) * find_root_super_simple(g,0,1,100000,0.01);
    lower_index = 2;
elseif (1-b)/(1-m)* epsilon_2 *a >  b/m * epsilon_1 * a
    g = @(x) b/m *((1-a)*(1/epsilon_1)*x.^((1/epsilon_1)-1)+a*epsilon_1*(1-x).^(epsilon_1-1))- a*(1-b)/(1-m)*epsilon_2;
    x_l = m * find_root_super_simple(g,0,1,100000,0.01);
    lower_index = 1;
end

% Now calculate values until x_l
i = 1;
if lower_index == 1
    
    while x_grid(i) <= x_l
    
        result(i) = b * mixed_lorenz(x_grid(i)/m,epsilon_1,a);
        i = i+1;
    end
    
elseif lower_index == 2
        while x_grid(i) <= x_l
    
        result(i) = (1-b) * mixed_lorenz(x_grid(i)/(1-m),epsilon_2,a);
        i = i+1;
        end
end

% Now make deconvolution and calculate the values of the merged lorenz curve
% according to Mr. Kämpke's paper.

for k = i : length(x_grid)-1
    % delta, to avoid root finding algorithm receives values, which are
    % infinity
    x_min = max(0,m+x_grid(k) -1);
    x_max = min(x_grid(k),m);
    f = mixed_lorenz_density_function(epsilon_1,epsilon_2,a,x_grid(k),m,b);
    x_1 = find_root_super_simple(f,x_min,x_max,100000,0.1);
    
    % Caution: The choice of the tolerance (last argument) is crucial. For
    % tolerance too low, algorithm can not find solution. For high
    % precision choose number of tries to be higher ( second to last
    % argument). Nasty, simple root finder, but relatively stable.
    % Finding the root of f is weakness of approach.
    
    result(k) = b * mixed_lorenz(x_1/m,epsilon_1,a) + (1-b) * mixed_lorenz((x_grid(k)-x_1)/(1-m),epsilon_2,a);
    
end

result(length(result))=1;
% Nasty solution: F(1) can not be solved by the convolution rules

plot(x_grid,result)
axis ([0 1 0 1])
grid on
y = [x_grid;result];
