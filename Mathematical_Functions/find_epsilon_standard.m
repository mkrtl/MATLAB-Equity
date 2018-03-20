function y = find_epsilon_standard(Equity,a)

f=@(epsilon,x) a* (1-(1-x).^epsilon) + (1-a) * x.^(1/epsilon);
cum_dist = Equity.cumulated_dist_vector;
pop = Equity.share_pop;

opts = optimset('Display','off');

[eps,error] = lsqcurvefit( f, 0.5 , pop, cum_dist, 0, 1, opts);

%RMSE = sqrt(error);

%y = real([eps,RMSE]);

y = real(eps);