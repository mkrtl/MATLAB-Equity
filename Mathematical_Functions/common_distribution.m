function y = common_distribution(vector, name)

% This function takes a vector of State objects, calculates the joint 
% income distribution of these objects and finally generates an Equity
% object with the caclulated values. The second argument determines the
% value of Equity.name for this object and is supposed to be a string.


income = zeros (length(vector)*(length(vector(1).income_per_head_in_share)),1);
population = zeros (length(vector)*(length(vector(1).persons_in_share)),1);

% Create empty vectors, which later will save all income and population 
% data. 

for k = 1 : length(vector)
    
    % For every country in vector, read in income and population  
    % data for every share. 
    
    
    income_per_head_share = vector(k).income_per_head_in_share;
    population_share = vector(k).persons_in_share;
    
    for i = 1 : length(vector(1).persons_in_share) 
        
        income(length(vector(1).income_per_head_in_share)*(k-1) + i) = income_per_head_share(i) ;
        population(length(vector(1).persons_in_share)*(k-1) + i) = population_share(i);
        
        % Fill vector with the data for country k.
        
    end
end


total_income = sum(income.*population);

% Calculate total income which is sum over "income per head in share" *
% persons in share

total_population = sum(population); 
% Used for normalizing the total population.
result_vector = [income, population];
% Auxiliary vector, which saves the income of a share in the first column
% and the average income of exactly this share in the second column.

result_vector = sortrows(result_vector,1);
% Sort rows, with regards to the average income in each share.
dist_vector = (result_vector(:,1) .* result_vector(:,2)) / total_income;
% Calculate relative share of income with regards to world's total income.

share_pop = cumsum(result_vector(:,2)) / total_population;
% Calculate share with regards to the total world population.
y = Equity(name, dist_vector , share_pop);
