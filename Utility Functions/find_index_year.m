function y=find_index_year(obj_array,country_name,year_of_data)
% For an array of State objects finds the index of a certain country and a certain year of the dataset. 
% Returns a row vector of integers. 
result = [];
for i=1:length(obj_array)
    if obj_array(i).country==country_name && obj_array(i).year_of_data == year_of_data
        result=[result,i];
    end
end
y = result;
