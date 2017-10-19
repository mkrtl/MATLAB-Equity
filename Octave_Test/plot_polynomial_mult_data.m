function y=plot_polynomial_mult_data(varargin)

% Plots Polynomial Lorenz curve of multiple countries, while using
% the epsilon found by using World Bank's Gini index.
% Function is able to plot multiple objects in the same plot. Function is
% function for State objects.
n_states=length(varargin);                                    
    
for i=1:n_states
    eps=varargin{i}.epsilon;
    f=@(x) (x).^(1./eps);
    y=plot(varargin{i}.share_pop,varargin{i}.cumulated_dist_vector,'+',0:0.001:1,f(0:0.001:1),'DisplayName',varargin{i}.country);
    legend('show','Location','northwest')
    hold on
end 
legend('Daten Weltbank','Polynomial Lorenzkurve','Location','northwest');
title('Polynomial Lorenzkurve (USA)')
xlabel('Bevölkerungsanteil')
ylabel('Einkommensanteil')

str = join(['USA ',string(varargin{1}.year_of_data)]);
dim_1 = [.15 .53 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';

epsilon_str =   join(['G = ',string(round(varargin{1}.gini_data,2))]);
dim_2 = [0.15 0.49 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 12;
box_2.LineStyle = 'None';
grid on


hold off



print(join([varargin{i}.country,'_Polynomial','.png']), '-dpng', '-r300');

hold off
end
