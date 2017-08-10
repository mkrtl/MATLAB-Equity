function y=plot_mixed_mult_model(varargin)

% Plots Pareto Lorenz curve of multiple countries, while using
% the epsilon found by fitting the mixed Lorenz curve to the given data.
% Function is able to plot multiple objects in the same plot. Function is
% function for Equity objects.
a = 0.6;
n_states=length(varargin);  
    
for i=1:n_states
    eps=varargin{i}.epsilon_model;
    eps = eps(1);
    f=@(x) a * (1-(1-x).^eps) + (1-a) * x.^(1/eps);
    y = plot(0:0.001:1,f(0:0.001:1),varargin{i}.share_pop,varargin{i}.cumulated_dist_vector,'.','DisplayName',varargin{i}.country);
    legend('show','Location','northwest')
    hold on
end 
% legend('show','Location','northwest');
xlabel('Einkommensanteil x','FontSize',14)
ylabel('kumuliertes Einkommen','FontSize',14)

grid on
hold off
% err = sum((f(varargin{i}.share_pop)-varargin{i}.dist_vector).^2)/length(varargin{i}.share_pop)
end
