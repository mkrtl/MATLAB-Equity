% Plot EU of 2002 today and the EU of 2002
% Run generate_EU_2002 and generate_EU_today_members_2002 first

%%
x_grid = 0:0.001:1;
a = 0.6;
plot(EU2002_today.share_pop,EU2002_today.cumulated_dist_vector,'.',...
    x_grid,mixed_lorenz(x_grid,EU2002_today.epsilon_model,0.6),...
    EU2002_common.share_pop,EU2002_common.cumulated_dist_vector,'.',...
    x_grid,mixed_lorenz(x_grid,EU2002_common.epsilon_model,0.6))




legend('Income Data World Bank 2002','Mixed Lorenz Curve 2002','Income Data World Bank 2016',...
    'Mixed Lorenz Curve 2016','Location','northwest');
xlabel('Cumulated Population Share')
ylabel('Cumulated Income Share')


str = "EU 2002";
dim_1 = [.15 .53 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';
grid on

epsilon_str =  "G = 0.32" ;
dim_2 = [0.15 0.49 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 12;
box_2.LineStyle = 'None';

str = "EU 2002 Today";
dim_3 = [.15 .44 0 0];
box_3 = annotation('textbox',dim_3,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_3.FontSize = 12;
box_3.LineStyle = 'None';

epsilon_str =   "G = 0.33";
dim_4 = [0.15 0.40 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';

print('Figure_5','-depsc','-r900')

