function y = poverty_studies_mixed_lorenz(factor_of_mean_income,varargin) 

% Poverty studies with mixed Lorenz-curve and a = 0.6 
% Takes equity parameter epsilon as input and plot the lorenz densities of
% the mixed Lorenz curve for all incomes lower previously determined factor
% of the mean income

if  ~isa(varargin{1},'double')
    disp ("Input is not a double. Insert epsilon value of object!")
    return
end


x_grid = linspace(0,1,1000);
a=0.6;
figure;
for i = 1:size(varargin,2)
    
    epsilon=varargin{i};
    f = @(x) (1-a) * (1/epsilon) * x.^((1/epsilon)-1)+ a * epsilon * (1-x).^(epsilon-1);
    plot(x_grid,f(x_grid),'DisplayName',num2str(varargin{i}));
    hold on 
    
end

x_limit = find_inverse_value_density_mixed( factor_of_mean_income, 0.6 , max(cell2mat(varargin))); 
%sets limit of x values, such that every curve is plotted completely 
title('Mixed Lorenzdichten fuer "a = 0.6"')
xlabel('Einkommensposition')
ylabel('Einkommen / Durchschnittseinkommen')
grid on
axis([0 x_limit 0 (factor_of_mean_income) ]);
legend('show','Location','northwest')
hold off
    
end