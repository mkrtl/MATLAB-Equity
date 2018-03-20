function y = find_indices_before(country_vector,year)

years = zeros(length(country_vector),1);

for i = 1 : length(years)
    
    years(i) = country_vector(i).year_of_data;
    
end

y = country_vector( years <= year);

