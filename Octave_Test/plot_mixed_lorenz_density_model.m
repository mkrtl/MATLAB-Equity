function plot_mixed_lorenz_density_model(varargin)
% This function plots Lorenz densities for Equity objects, using the
% epsilon through fitting the Lorenz curve through the given data points.
a = 0.6;
for i=1:length(varargin)
f = @(x) (1-a) * (1/varargin{i}.epsilon_model) * x.^((1/varargin{i}.epsilon_model)-1)+ a * varargin{i}.epsilon_model * (1-x).^(varargin{i}.epsilon_model-1);
% Lorenz density
plot (0:0.001:1, f(0:0.001:1),'DisplayName',varargin{i}.country)
% Setting of label and plotting
hold on
end
xlabel('Einkommensanteil x','FontSize',14)
ylabel('Anteil am Durchschnittseinkommen','FontSize',14)
grid on
hold off
% legend('show','Location','northwest');

axis([0 0.7 0 1])
% Fixing of axis to ensure readability of graph