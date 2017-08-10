A = readtable('Kämpke_2002_EU.xlsx');
Einkommen = A.Einkommen;
Bev = A.Bev_lkerung;
x = 0:0.001:1;
plot(Bev,Einkommen,'.',x,mixed_lorenz(x,(1-0.32)/(1+0.32),0.6),EU_today_common.share_pop,EU_today_common.cumulated_dist_vector,'.',x,mixed_lorenz(x,EU_today_common.epsilon_model,0.6))
xlabel('Bevölkerungsanteil')
ylabel('Einkommensanteil')
legend('Daten Weltbank 2002','Standard Lorenzkurve 2002','Daten Weltbank 2016', 'Standard Lorenzkurve 2016','Location','northwest')
str = 'EU 2002';
dim_1 = [.15 .62 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';

epsilon_str =  'G=0.32';
dim_2 = [0.15 0.58 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 12;
box_2.LineStyle = 'None';

str = 'EU 2016'
dim_3 = [.15 .54 0 0];
box_3 = annotation('textbox',dim_3,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_3.FontSize = 12;
box_3.LineStyle = 'None';

epsilon_str =  'G = 0.37';
dim_4 = [0.15 0.50 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
grid on
print('EU_Standard_Lorenz_Vergleich.png', '-dpng', '-r300');
