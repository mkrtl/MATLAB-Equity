function plot_mixed_lorenz_density_data(varargin)
% This function plots Lorenz densities for State objects, using the
% epsilon found by calculating the epsilon via the World Bank's Gini index.
a = 0.6;
for i=1:length(varargin)
f = @(x) (1-a) * (1/varargin{i}.epsilon) * x.^((1/varargin{i}.epsilon)-1)+ a * varargin{i}.epsilon * (1-x).^(varargin{i}.epsilon-1);
% Lorenz density
plot (0:0.001:1, f(0:0.001:1),'DisplayName',varargin{i}.country)
grid on
% Setting of label and plotting
hold on
end
hold off
legend('show','Location','northwest');
axis([0 1 0 5])
% Fixing of axis to ensure readability of graph