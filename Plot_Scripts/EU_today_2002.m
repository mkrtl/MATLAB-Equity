% Compares EU of today with EU of 2002
% Stand: 26.01.2018
EU2002_common = generate_EU_2002();
EU_2002_kaempke;
x = 0:0.001:1;

plot(EU2002_kaempke.share_pop,EU2002_kaempke.cumulated_dist_vector,'.',x,mixed_lorenz(x,EU2002_kaempke.epsilon_model,0.6),EU_today_common.share_pop,EU_today_common.cumulated_dist_vector,'.',x,mixed_lorenz(x,EU_today_common.epsilon_model,0.6))
xlabel('Cumulative Population Share')
ylabel('Cumulutative Income Share')
legend('Income Data World Bank 2016', 'Mixed Lorenz Curve 2016','Income Data World Bank 2002','Mixed Lorenz Curve 2002','Location','northwest')
str = 'EU 2002';
dim_1 = [.15 .44 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';

epsilon_str =  join(["G = ",string(round(EU2002_kaempke.gini_model,2))]);
dim_2 = [0.15 0.40 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 12;
box_2.LineStyle = 'None';

str = 'EU 2016';
dim_3 = [.15 .53 0 0];
box_3 = annotation('textbox',dim_3,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_3.FontSize = 12;
box_3.LineStyle = 'None';

epsilon_str =  join(["G = ",string(round(EU_today_common.gini_model,2))]);
dim_4 = [0.15 0.49 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
grid on
print('Figure_6', '-depsc', '-r900');
