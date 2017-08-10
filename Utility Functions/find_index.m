function y=find_index(obj_array,country_name)
% For an array of Equity objects finds the index of a certain country. 
% Returns a row vector of integers. 
result = [];
for i=1:length(obj_array)
    if obj_array(i).country==country_name
        result=[result,i];
    end
end
y = result;
