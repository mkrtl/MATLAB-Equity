function plot_standard_lorenz_density_gui(indexes_used,states_vector)

% Plot standard lorenz density of a given selection (indexes_used) of a
% vector of states objects. This function is used for
% plot_standard_lorenz_gui.


indexes_used = unique(indexes_used,'stable');

% Make sure, that every country is just plotted once, meaning it just
% appears once in indexes_used and country_names. Keep order of those
% arrays ( which is achieved by 'stable').

% x_grid: 

x_values = 0: 0.001:1;

a = 0.6;
% Initialize legend entries: 

legend_entries = strings(1,length(indexes_used));

% Plot densities:

for i = 1 : length(indexes_used)
    
    legend_entries(i) = join([states_vector(indexes_used(i)).country," ",states_vector(indexes_used(i)).year_of_data]);
    % Legend entries of Lorenz densities:
    plot(x_values,mixed_lorenz_density(x_values,states_vector(indexes_used(i)).epsilon,a))
    hold on
    
end

legend(legend_entries,'Location','Northwest')
legend('show')   
title('Standard Lorenzdichte')
xlabel('Bevölkerungsanteil x')
ylabel('Vielfaches des Durchschnittseinkommens')
grid on

% Set y- Limit, such that 99 % of all x-values can be seen:
y_limit = zeros(1,length(indexes_used));
for i = 1 : length(indexes_used)
    y_limit(i) = mixed_lorenz_density(0.99,states_vector(indexes_used(i)).epsilon,a);
end
    
ylim([0 max(y_limit)]) 

hold off
