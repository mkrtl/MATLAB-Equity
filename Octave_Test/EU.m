% plot EU Data of the members of the EU in 2002 and create an equity object with the most recent dataset for every country

%% 
clear all
%% Generate_all_countries_historic
generate_all_countries;

%% Create the EU of 2002 with most recent datasets and calls the Equity object EU2002_today.
EU_names = ["Slovenia","Croatia","Estonia","Latvia","Hungary","Czech Republic","Cyprus","Bulgaria","Belgium","Denmark","Germany","Finland","France","Greece","Ireland","Italy","Luxembourg","Netherlands","Austria","Portugal","Sweden","Spain","United Kingdom"];
length(EU_names)
for i = 1 : length(EU_names)
    index = find_index(wbd_data,EU_names(i))
    EU_today(i) = wbd_data(index)
    
end
EU_today
EU_today_common = common_distribution(EU_today, "EU_today");

%% Plot the distribution
%plot(0:0.01:1,mixed_lorenz(0:0.01:1,find_epsilon_simple(EU_2002_today,1000,0.6),0.6),EU_2002_today.share_pop,EU_2002_today.cumulated_dist_vector,'+')




