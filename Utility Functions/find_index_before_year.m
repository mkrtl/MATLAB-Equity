function y = find_index_before_year(vector_equity,country,year)

% For a given country, a given vector and a given year, this function
% returns the index in this vector, whose entry is before the given year
% and the most recent in that year. 
% !!! If there is no dataset before that timepoint, the oldest entry is
% chosen. !!!

% Find indices, which are available for this country:
data_sets = find_index(vector_equity,country);

% Fill the available years in a vector: 

for i = 1 : length(data_sets)
    years_data(i) = vector_equity(data_sets(i)).year_of_data;
end

% If there is an entry older than the given year:
if min(years_data)<= year
    
    years_data_before = years_data(years_data <= year);

    year_final = max(years_data_before-year)+year ;

else
    % Choose oldest entry otherwise:
    year_final = min(years_data);
end


y = find_index_year(vector_equity,country,year_final);



