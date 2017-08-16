function y=find_index_year(obj_array,country_name,year_of_data)
% For an array of State objects finds the index of a certain country and a certain year of the dataset. 
% Returns usually just one dataset. In case of multiple datasets for one
% year and country, it returns a row vector of indexes.

result = [];
for i=1:length(obj_array)
    if obj_array(i).country==country_name && obj_array(i).year_of_data == year_of_data
        result=[result,i];
    end
end
y = result;
