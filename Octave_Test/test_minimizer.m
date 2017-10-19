function y = test_minimizer(object)

% Minimizes the mse for a Equity object while varying the epsilons and a.
% The epsilons are not necessarily equal and this program returns therefore
% a vector of three parameters. The first entry is the optimal a, the
% second entry is the optimal epsilon of the Pareto curve and the third
% entry is the optimal entry of the Polynomial curve. Is more exactly than 
% find_epsilons_a_epsilons. 

pop = object.share_pop;
cum_dist = object.cumulated_dist_vector;
f = @(var,pop) var(1)* (1-(1-pop).^var(2)) + (1-var(1)) * pop.^(1/var(3));

opts = optimset('Display','off');
[parameters,error] = lsqcurvefit(f,[0.5 0.5 0.5] ,pop,cum_dist,[0 0 0],[1 1 1],opts);
y = [parameters,error];


