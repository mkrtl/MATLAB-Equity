function y = a_vs_epsilon(state_vector)

% For a given vector of state-objects, makes a scatter plot of
% Epsilon-values vs. optimal a-values.

result = zeros(length(state_vector),2);
for i = 1 : length(state_vector) 
    result(i,1) = state_vector(i).epsilon;
    result(i,2) = find_optimal_a(state_vector(i));
end

y = scatter(result(:,1),result(:,2)); 
hold on
xlabel('Epsilon-Values')
ylabel('Optimal a')   
hold off