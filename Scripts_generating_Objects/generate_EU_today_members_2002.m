%EU Data of the members of the EU in 2002 and create an equity object with the most recent dataset for every country

function y = generate_EU_today_members_2002()

wbd_data = generate_all_countries();

% Create the EU of 2002 with most recent datasets and calls the Equity object EU2002_today.
EU_2002_names = ["Belgium","Denmark","Germany","Finland","France","Greece","Ireland","Italy","Luxembourg","Netherlands","Austria","Portugal","Sweden","Spain","United Kingdom"];
for i = 1 : length(EU_2002_names)
EU_2002_today_array(i) = wbd_data(find_index(wbd_data,EU_2002_names(i)));
end
EU2002_today = common_distribution(EU_2002_today_array, "EU_2002_today");

y = EU2002_today;
%% Plot the distribution
%plot(0:0.01:1,mixed_lorenz(0:0.01:1,find_epsilon_simple(EU2002_today,1000,0.6),0.6),EU2002_today.share_pop,EU2002_today.cumulated_dist_vector,'+')




