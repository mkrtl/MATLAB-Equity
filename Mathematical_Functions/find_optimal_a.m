function y = find_optimal_a(State)

% Finds a for a given state object, which minimzes the mean square error to
% the World Bank's Data points. Uses the epsilon of the data as fixed input
% and just varies a. 

opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = 0.5;      % Starting point of search

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( State.share_pop', State.cumulated_dist_vector' );

epsilon = State.epsilon;

ft = fittype(['a*(1-(1-x)^ ' num2str( epsilon ) ')+(1-a)*x^(1/' num2str(epsilon) ')'] , 'independent', 'x', 'dependent', 'y');


% Fit model to data.
fitresult = fit( xData, yData, ft, opts );
y = fitresult.a;
end
