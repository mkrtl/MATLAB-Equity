function Plot_java_example(indexes_used,datapoints_boolean)
states_vector = generate_all_countries_historic;
% This function plots the standard lorenz curve for a given vector of
% states, a selection of those states (indexes) used and indicates, whether
% or not the datapoints should be plotted. Is used for
% plot_states_historic.

indexes_used = unique(indexes_used,'stable');
% Just keep one index

country_names = strings(length(indexes_used),1);
% Name of the countries plotted
x_values = 0:0.001:1;
% x_grid
% Fill array of country_names:

for i = 1 : length(indexes_used)
    country_names(i) = join([states_vector(indexes_used(i)).country, " ",states_vector(indexes_used(i)).year_of_data]);
end

% Make sure, that every country is just plotted once, meaning it just
% appears once in indexes_used and country_names. Keep order of those
% arrays ( which is achieved by 'stable'):


country_names = unique(country_names,'stable');

% Plot datapoints and Lorenz curve seperately:

for i = 1 : length(indexes_used)
    epsilon = states_vector(indexes_used(i)).epsilon;
    curves(i) = plot(x_values,mixed_lorenz(x_values,epsilon,0.6));
    hold on
    datapoints(i) = plot(states_vector(indexes_used(i)).share_pop,states_vector(indexes_used(i)).cumulated_dist_vector,'+');
end
hold off
% Check for 'Datapoints' and decide whether or not to display
% them:
if datapoints_boolean
    set(datapoints,'Visible','On')
else
    set(datapoints,'Visible','Off')
end     
    legend_entries = strings(1, 2 * length(indexes_used));
for i = 1 : length(indexes_used)
    
    legend_entries(2*i-1) = country_names(i);
    % Legend entries of Lorenz Curves
    
    legend_entries(2*i) = join(["Daten ",country_names(i)]);
    % Legend entries of datapoints
end

legend(legend_entries,'Location','Northwest')
legend('show')   
title('Standard Lorenzkurve')
xlabel('Bevölkerungsanteil x')
ylabel('Einkommensanteil')
grid on
hold off
