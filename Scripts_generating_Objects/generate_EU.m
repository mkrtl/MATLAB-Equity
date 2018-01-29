
function y = generate_EU()
wbd_data = generate_all_countries();

%% Create the EU of today, with 27 available datasets. Malta is missing.
EU_names = ["Poland","Lithuania","Slovenia","Croatia","Estonia","Latvia","Hungary","Slovak Republic","Czech Republic","Cyprus","Bulgaria","Belgium","Denmark","Germany","Finland","France","Greece","Ireland","Italy","Luxembourg","Netherlands","Austria","Portugal","Sweden","Spain","United Kingdom","Romania"];
EU_names = unique(EU_names);
for i = 1 : length(EU_names)
    index = find_index(wbd_data,EU_names(i));
    EU_today(i) = wbd_data(index);
    
end
y = common_distribution(EU_today, "EU_today");




