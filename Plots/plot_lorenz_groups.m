function plot_lorenz_groups(vector_equity_objects, datapoints_boolean, curves_boolean)



x_values = 0:0.001:1;
% x_grid
% Fill array of country_names:


% Plot datapoints and Lorenz curve seperately:

for i = 1 : length(vector_equity_objects)
    epsilon = find_epsilon_simple(vector_equity_objects(i),1000,0.6);
    curves(i) = plot(x_values,mixed_lorenz(x_values,epsilon,0.6));
    hold on
    datapoints(i) = plot(vector_equity_objects(i).share_pop,vector_equity_objects(i).cumulated_dist_vector,'+');
end
hold off
% Check for 'Datapoints' and decide whether or not to display
% them:
if datapoints_boolean
    set(datapoints,'Visible','On')
else
    set(datapoints,'Visible','Off')
end     

% Check for 'Curves' and decide whether or not to display
% them:

if curves_boolean
    set(curves,'Visible','On')
else
    set(curves,'Visible','Off')
end 

xlim([0 1])
ylim([0 1])


for i = 1 : length(vector_equity_objects)
    
    legend_entries(2*i-1) = vector_equity_objects(i).country;
    % Legend entries of Lorenz Curves
    
    legend_entries(2*i) = join(["Daten ",vector_equity_objects(i).country]);
    % Legend entries of datapoints
end

legend(legend_entries,'Location','Northwest')
legend('show')   
title('Standard Lorenzkurve')
xlabel('Bevölkerungsanteil x')
ylabel('Einkommensanteil')
grid on
hold off