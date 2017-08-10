function y = merged_lorenz_curve_paper(m,b,epsilon_1,epsilon_2,a) 
% Calculates a merged lorenz curve according to paper " A straightforward
% calculus" by Professor Kämpke. Uses the MATLAB algorithm
% "fzero" for calculating the values of the deconvolution
% and is therefore less stable as merged_lorenz_curve_paper_simple. 
 
% CAUTION: Curve is not really normalized, i.e. F(1-delta) < 1 for all delta > 0 usually.
% There is a nasty solution implemented by setting F(1) =1 
% F(1) can not be calculated by the strucure of the convolution.


% Achtung!! Funktioniert nicht. Problem: Finde Punkte, sodass
% f_zero-Funktion Startwert < 0 und Startwert > 0 erhält. Sehr diffizil.


% Initialize grid and result array
x_grid = linspace(0,1,1000);
result = zeros(1,length(x_grid));
% Now calculate x_l
if (1-b)/(1-m)* epsilon_2 *a <= b/m * epsilon_1 * a
    g = @(x) (1-b)/(1-m) *((1-a)*(1/epsilon_2)*x.^((1/epsilon_2)-1)+a*epsilon_2*(1-x).^(epsilon_2-1)) - a*(b/m)*epsilon_1;
    x_l = m * fzero(g,[0 0.999])
    lower_index = 2;
elseif (1-b)/(1-m)* epsilon_2 *a >  b/m * epsilon_1 * a
    g = @(x) b/m *((1-a)*(1/epsilon_1)*x.^((1/epsilon_1)-1)+a*epsilon_1*(1-x).^(epsilon_1-1))- a*(1-b)/(1-m)*epsilon_2;
    x_l = m * fzero(g,[0 0.999])
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

% Now make deconvolution
f_1 = @(x_1,b,m,a,epsilon_1,epsilon_2) (b/m)*((1-a)*(1/epsilon_1)*(x_1/m).^((1/epsilon_1)-1)+a*epsilon_1*(1-(x_1/m)).^(epsilon_1-1));
f_2 = @(x_1,b,m,a,epsilon_1,epsilon_2,x) (1-b)/(1-m)*((1-a)*(1/epsilon_2)*((x-x_1)/(1-m)).^((1/epsilon_2)-1)+a*epsilon_2*(1-(x-x_1)/(1-m)).^(epsilon_2-1));

for k = i : length(x_grid)-1
    %x_min = max(0,m+x_grid(i) -1)
    %x_max = min(x_grid(i),m)
    f_3 = @(x_1) f_1(x_1,b,m,a,epsilon_1,epsilon_2)-f_2(x_1,b,m,a,epsilon_1,epsilon_2,x_grid(k));

    % f = mixed_lorenz_density_function(epsilon_1,epsilon_2,a,x_grid(i),m,b);
    for j = 1 : length(x_grid)
        if f_3(x_grid(j)) < 0 
            x_min = x_grid(j)
        end
    end
    
    for j = length(x_grid):1
        if f_3(x_grid(j)) > 0 
            x_max = x_grid(j)
        end
    end
    
        f_3(x_min)
        f_3(x_max)

        x_1 = fzero(f_3,[x_min x_max]);
    
    result(k) = b * mixed_lorenz(x_1/m,epsilon_1,a) + (1-b) * mixed_lorenz((x_grid(k)-x_1)/(1-m),epsilon_2,a);
    % Main issue: find limits, s.t. f of limits differs in sign.
end
result(length(result))=1;
% Nasty solution: F(1) can not be solved by the convolution rules
plot(x_grid,result)
y = [x_grid;result];
