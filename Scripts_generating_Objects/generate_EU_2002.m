% EU-Data from 2004 and generate State object of all EU members, 
% which were members in the year 2002.

function y = generate_EU_2002();

wbd_data_historic = generate_all_countries_historic();

%% Create the EU of 2002 with datasets as near as possible to 2002
EU_2002_names = ["Belgium","Denmark","Germany","Finland","France","Greece","Ireland","Italy","Luxembourg","Netherlands","Austria","Portugal","Sweden","Spain","United Kingdom"];
EU2002 = [];
for i = 1 : length(EU_2002_names)
    country_index = find_index(wbd_data_historic,EU_2002_names(i));
    
    for j = 1 : length(country_index)
        if wbd_data_historic(country_index(j)).year_of_data <= 2002
            EU2002 = [EU2002,wbd_data_historic(country_index(j))];
            break
            
        elseif j == length(country_index)
            EU2002 = [EU2002,wbd_data_historic(country_index(length(country_index)))];
        end
    end    
end
y = common_distribution(EU2002,"EU2002");
        
        
     
        

        
    
    





