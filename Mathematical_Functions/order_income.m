function result = order_income(share_pop , dist_vector)

% Orders arbitrary vector of population and its distribution of income,
% such that it can be used for building an equity object. 

if size(share_pop) ~= size(dist_vector)
    disp("Sizes of vectors do not fit")
    return 
end

avg_income_in_share = dist_vector ./ share_pop;

matrix_to_order = [share_pop, dist_vector, avg_income_in_share];

sort_result = sortrows(matrix_to_order,3);

share_pop_result = sort_result(:,1)./sum(share_pop);

share_pop_result = [0;cumsum(share_pop_result)];

dist_vector_result = [0;sort_result(:,2)./sum(dist_vector)];

result = [share_pop_result , dist_vector_result];

