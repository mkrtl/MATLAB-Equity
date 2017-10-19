% This script plots the world income distribution described by Mister
% Kämpke in his technical report, the world income distribution of today
% and the mixed lorenz curve fitted through today's world income
% distribution. 
% Run generate_all_countries and Welt_2002_neu first.

generate_all_countries; 
% Equity object is called World
Welt_2002;
% Equity object is called Welt_2002_kaempke

World = wbd_data; 
World = common_distribution(World,"World");

% Generates objects

x = 0:0.001:1;

plot(World.share_pop,World.cumulated_dist_vector, '.',x,mixed_lorenz(x,find_epsilon_simple(World,1000,0.6),0.6))
hold on



plot(x,mixed_lorenz(x,find_epsilon_simple(Welt_2002_kaempke,1000,0.6),0.6), Welt_2002_kaempke.share_pop, Welt_2002_kaempke.cumulated_dist_vector, '.' );
hold on
axis([0 1 0 1])
legend('Daten Weltbank 2016','Standard-Lorenzkurve 2016','Daten Weltbank 2002','Standard-Lorenzkurve 2002','Location','northwest');
legend('show');
xlabel('Bevölkerungsanteil x')
ylabel('Einkommensanteil')

grid on 
hold off

