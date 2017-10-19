
%%% Mixed Lorenz Curves Fitting Function, with a fixed %%%
%Directly derived from problem "finding best a"

function y = find_epsilon_pareto(Equity)
%Matlab function. Finds epsilon by fitting the Pareto Lorenz curve to given data points 
%and minimizing the mean square error. 

x=Equity.share_pop'; 




%% Fit: 'untitled fit 1'. % preparing the variables for the fit function
y=Equity.cumulated_dist_vector';

[xData, yData] = prepareCurveData( x, y );


% Set up fittype and options.
ft = fittype( ' (1-(1-x)^epsilon )', 'independent', 'x', 'dependent', 'y' ); % we can define more than 1 number of optimization parameter
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = 0.2;

% Fit model to data.
fitresult = fit( xData, yData, ft, opts ); 
y = fitresult.epsilon;
% fitresult is an object including optimized parameters (here is the "epsilon"), 
%gof is a structure, including statistics regarding the goodness of the fit



