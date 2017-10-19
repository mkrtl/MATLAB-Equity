% plot EU Data of the members of the EU in 2002 and create an equity object with the most recent dataset for every country

%% Generate_all_countries_historic
generate_all_countries_historic;

%% Create the EU of 2002 with most recent datasets and calls the Equity object EU2002_today.
EU_2002_names = ["Belgium","Denmark","Germany","Finland","France","Greece","Ireland","Italy","Luxembourg","Netherlands","Austria","Portugal","Sweden","Spain","United Kingdom"];
for i = 1 : length(EU_2002_names)
EU_2002(i) = wbd_data_historic(min(find_index(wbd_data_historic,EU_2002_names(i))));
end
EU2002_today = common_distribution(EU_2002, "EU_2002_today");

%% Plot the distribution
plot(0:0.01:1,mixed_lorenz(0:0.01:1,find_epsilon_simple(EU_2002_today,1000,0.6),0.6),EU_2002_today.share_pop,EU_2002_today.cumulated_dist_vector,'+')




