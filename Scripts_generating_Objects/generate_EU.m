%EU Data of the members of the EU in 2002 and create an equity object with the most recent dataset for every country

function y = generate_EU()
wbd_data = generate_all_countries();

%% Create the EU of today, with 23 available datasets.
EU_names = ["Slovenia","Croatia","Estonia","Latvia","Hungary","Czech Republic","Cyprus","Bulgaria","Belgium","Denmark","Germany","Finland","France","Greece","Ireland","Italy","Luxembourg","Netherlands","Austria","Portugal","Sweden","Spain","United Kingdom"];
for i = 1 : length(EU_names)
    index = find_index(wbd_data,EU_names(i));
    EU_today(i) = wbd_data(index);
    
end
y = common_distribution(EU_today, "EU_today");




