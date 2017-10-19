function y = find_root_super_simple(g,a,b,n,tolerance)
% Is a simple but stable algorithm for finding roots. Simply generates a
% grid given by a,b and n and tries for every element of the grid, whether
% the absolut value of the function at that point is lower than the
% tolerance. 

x_grid = linspace(a,b,n); 
for i = 1 : length(x_grid)
    
    if abs(g(x_grid(i))) < tolerance 
        y = x_grid(i);
        break    
    end
    if x_grid(i) == b
        disp("There is no root")
        break
    end
    

end
