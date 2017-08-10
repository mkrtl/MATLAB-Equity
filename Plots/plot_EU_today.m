% plot EU-Data 
EU_names = ["Bulgaria","Croatia","Estonia","Latvia","Poland","Romania","Slovak Republic","Slovenia","Hungary","Czech Republic","Cyprus","Belgium","Denmark","Germany","Finland","France","Greece","Ireland","Italy","Luxembourg","Netherlands","Austria","Portugal","Sweden","Spain","United Kingdom"];
for i = 1 : length(EU_names)
EU_today(i) = wbd_data_historic(min(find_index(wbd_data_historic,EU_names(i))));
end
EU_today_common = common_distribution(EU_today, "EU_today");
plot(0:0.01:1,mixed_lorenz(0:0.01:1,find_epsilon_simple(EU_today_common,1000,0.6),0.6),EU_today_common.share_pop,EU_today_common.cumulated_dist_vector,'+')

%Zeigt dir hier nochmal den durch Fitten ermittelten Epsilon-Wert an.

epsilon_EU = find_epsilon_simple(EU_today_common,1000,0.6)