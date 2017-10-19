function y=plot_mixed_mult_data(a,varargin)

% Plots Pareto Lorenz curve of multiple countries, while using
% the epsilon calculated by the Gini-value of the World Bank.
% Function is able to plot multiple objects in the same plot. Function is
% function for Equity objects.
n_states=length(varargin);  
    
for i=1:n_states
    eps=varargin{i}.epsilon;
    f=@(x) a* (1-(1-x).^eps) + (1-a) * x.^(1/eps);
    y=plot(varargin{i}.share_pop,varargin{i}.cumulated_dist_vector,'+','DisplayName',varargin{i}.country,...
        0:0.001:1,f(0:0.001:1));
    hold on
end 
legend('Income Data World Bank','Pareto Lorenz Curve','Location','northwest');
xlabel('Cumulated Population Share')
ylabel('Cumulated Income Share')
% Achtung: Hier Namen des Landes anstatt 'USA' einsetzen !!!!
str = join(['USA ',string(varargin{1}.year_of_data)]);
dim_1 = [.15 .53 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';
grid on
hold off
end
