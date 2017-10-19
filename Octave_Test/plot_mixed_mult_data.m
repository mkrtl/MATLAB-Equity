function y=plot_mixed_mult_data(varargin)

% Plots Pareto Lorenz curve of multiple countries, while using
% the epsilon calculated by the Gini-value of the World Bank.
% Function is able to plot multiple objects in the same plot. Function is
% function for Equity objects.
a = 0.6;
n_states=length(varargin);  
    
for i=1:n_states
    eps=varargin{i}.epsilon;
    f=@(x) a* (1-(1-x).^eps) + (1-a) * x.^(1/eps);
    y=plot(0:0.001:1,f(0:0.001:1),varargin{i}.share_pop,varargin{i}.cumulated_dist_vector,'+','DisplayName',varargin{i}.country);
    hold on
end 
%legend('show','Location','northwest');
hold off
end
