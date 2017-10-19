function y=plot_mixed_mult_data(a,varargin)

% Plots Pareto Lorenz curve of multiple countries, while using
% the epsilon calculated by the Gini-value of the World Bank.
% Function is able to plot multiple objects in the same plot. Function is
% function for Equity objects.
n_states=length(varargin);  
varargin{1}.share_pop
for i=1:n_states
    eps = varargin{i}.epsilon;
    f=@(x) a* (1-(1-x).^eps) + (1-a) * x.^(1/eps);
    varargin{i}.share_pop
    y=plot(0:0.001:1,f(0:0.001:1),varargin{i}.share_pop,varargin{i}.cumulated_dist_vector,'+','DisplayName',varargin{i}.country)
        
    hold on
end 
legend('Income Data World Bank','Mixed Lorenz Curve','Location','northwest');
xlabel('Cumulative Population Share')
ylabel('Cumulative Income Share')

str = join([varargin{1}.country,string(varargin{1}.year_of_data)]);
dim_1 = [.15 .53 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';

str = join(["G = ",string(round(varargin{1}.gini_data,2))]);
dim_2 = [.15 .49 0 0];
box_2 = annotation('textbox',dim_2,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_2.FontSize = 12;
box_2.LineStyle = 'None';

grid on
hold off
end
