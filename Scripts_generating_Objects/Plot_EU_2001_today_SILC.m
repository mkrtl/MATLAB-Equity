% Plot EU of today and the EU of 2001 with EU-SILC-data.
% Stand: 28.01.2018

%%
EU_2001 = generate_EU2001_EUSILC;
EU_today = generate_EU_today_EUSILC;
x_grid = 0:0.001:1;
a = 0.6;
EU_2001_epsilon = find_epsilon_simple(EU_2001,1000,0.6);
EU_today_epsilon = find_epsilon_simple(EU_today,1000,0.6);
plot(    EU_today.share_pop,EU_today.cumulated_dist_vector,'.',...
    x_grid,mixed_lorenz(x_grid,EU_today_epsilon,0.6),EU_2001.share_pop,EU_2001.cumulated_dist_vector,'.',...
    x_grid,mixed_lorenz(x_grid,EU_2001_epsilon,0.6))


EU_today_gini = (1-EU_today_epsilon)/(1+EU_today_epsilon);
EU_2001_gini = (1-EU_2001_epsilon)/(1+EU_2001_epsilon);

legend('Income Data EU-SILC 2016',...
    'Standard Lorenz Curve 2016','Income Data EU-SILC 2001','Standard Lorenz Curve 2001','Location','northwest');
xlabel('Cumulative Population Share')
ylabel('Cumulative Income Share')


str = "EU 2001";
dim_1 = [.15 .44 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';
grid on

epsilon_str =  join(["G = ",num2str(round(EU_2001_gini,2))]) ;
dim_2 = [0.15 0.40 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 12;
box_2.LineStyle = 'None';

str = "EU Today";
dim_3 = [.15 .53 0 0];
box_3 = annotation('textbox',dim_3,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_3.FontSize = 12;
box_3.LineStyle = 'None';

epsilon_str =  join(["G = ",num2str(round(EU_today_gini,2))]) ;
dim_4 = [0.15 0.49 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';

xlim([0 1])
%%
print('EU2001_and_today','-depsc','-r900')

