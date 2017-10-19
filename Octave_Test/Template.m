function Template(varargin)
% Plots State objects automatically.
% in case of plot of one country, state object and its name as inputs.
% in case of a comparison, first two state objects, then their names.

for i = 1 : length(varargin)/2
set(0,'defaulttextInterpreter','none')
plot(varargin{i}.share_pop,varargin{i}.cumulated_dist_vector,'+')
hold on
epsilon = varargin{i}.epsilon;
plot(0:0.001:1,mixed_lorenz(0:0.001:1,epsilon,0.6),'-')
hold on
end

if length(varargin)==4
legend(join(['Daten Weltbank ',varargin{3},' ',string(varargin{1}.year_of_data)]),join(['Standard-Lorenzkurve ',varargin{3},' ',string(varargin{1}.year_of_data)]),join(['Daten Weltbank ',varargin{4},' ',string(varargin{2}.year_of_data)]),join(['Standard-Lorenzkurve ',varargin{4},string(varargin{2}.year_of_data)]),'Location','northwest');
else
    legend(join(['Daten Weltbank ',varargin{3},' ',string(varargin{1}.year_of_data)]),join(['Standard-Lorenzkurve ',varargin{3},' ',string(varargin{1}.year_of_data)]),'Location','northwest');
end


legend('show');
xlabel('Bevölkerungsanteil x')
ylabel('Einkommensanteil')

str = join([varargin{3},' ',string(varargin{1}.year_of_data)]);
dim_1 = [.15 .61 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 13;
box_1.LineStyle = 'None';

epsilon_str =   join(['G = ',string(varargin{1}.gini_data)]);
dim_2 = [0.15 0.57 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 13;
box_2.LineStyle = 'None';

if length(varargin)==4
str = join([varargin{4},' ',string(varargin{2}.year_of_data)]);
dim_1 = [.15 .53 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';

epsilon_str =   join(['G = ',string(varargin{2}.gini_data)]);
dim_2 = [0.15 0.49 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 12;
box_2.LineStyle = 'None';
end



grid on 
xlim([0 1]);
ylim([0 1]);
hold off

% if length(varargin)==4
%     print('Welt_Vergleich.png', '-dpng', '-r300');
% 
% else 
%     print(join([varargin{2},'.png']), '-dpng', '-r300');
% end





