function y=plot_pareto_mult_model(states)

% Plots Pareto Lorenz curve of multiple countries, while using
% the epsilon found by fitting the mixed Lorenz curve to the given data.
% Function is able to plot multiple objects in the same plot. Function is
% function for Equity objects.

n_states=length(states);  
    
for i=1:n_states
    eps=states(i).epsilon_model;
    f=@(x) 1-(1-x).^eps;
    y=plot(0:0.01:1,f(0:0.01:1),states(i).share_pop,states(i).cumulated_dist_vector,'+','DisplayName',states(i).country);
    hold on
end 
xlabel('Cumulative Population Share')
ylabel('Cumulative Income Share')

text_legend = [];
box_size = 0.09;
for i = 1 : n_states
    
    str = join([states(i).country,string(states(i).year_of_data)]);
    height = 0.53-(i-1)*box_size;
    dim_1 = [.15 height 0 0];
    box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
    box_1.FontSize = 12;
    box_1.LineStyle = 'None';
    
    str = join(["G = ",string(round(states(i).gini_data,2))]);
    height_2 = height - 0.04;
    dim_2 = [.15 height_2 0 0];
    box_2 = annotation('textbox',dim_2,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
    box_2.FontSize = 12;
    box_2.LineStyle = 'None';
    
    text_legend = [text_legend,strcat("Income Data World Bank ",states(i).country),strcat("Pareto Lorenz Curve ",states(i).country)];
end
legend('show','Location','northwest');
legend(text_legend);

grid on
hold off
end
