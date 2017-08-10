function y=find_epsilon_simple(Equity,n,a)

% Finds minimal epsilon by simply trying n different epsilon and gives back 
% the epsilon with the minimal mean square error for Pareto-curve. Also, it plots the mean square error
% depending on the different epsilon. 


x = Equity.share_pop;                  % population vector
epsilon = linspace(0,1,n);             % vector of possible epsilons. All possible epsilons are between 0 and 1.
F = zeros(length(x),length(epsilon));
% This matrix saves all the values of the pareto curve at all points of x in columns  
% with different epsilons (rows).  
     for i = 1:length(epsilon) , j = 1:length(x);
            g = @(x) a.* (1-(1-x).^epsilon(i)) + (1-a) .* x.^(1./epsilon(i));        % Mixed Lorenz function
            F(j,i) = g(x(j));
     end
     
 err = F - repmat(Equity.cumulated_dist_vector,1,length(epsilon));   % Error at every point of x and for every epsilon
 sq = err.^2;                                              % Error is squared
 mse = mean(sq);                                           % Mean is taken. Result is mean square error
 y = epsilon(find(mse==min(mse)));                         % Epsilon, where mean square error is minimal, is given back

 
 
 %figure
%plot(epsilon,mse,'--')                              %result is plotted
%title('eps vs. MSE')
%xlabel('eps')
%ylabel('MSE')
%grid on
%plot(0:0.001:1,mixed_lorenz(0:0.001:1,y,0.6))








