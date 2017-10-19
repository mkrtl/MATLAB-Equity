% Plot Welt 2002
generate_all_countries;
World = common_distribution(wbd_data,"World");
Welt_2002;
x_grid = 0:0.001:1;
plot(World.share_pop,World.cumulated_dist_vector,'.',...
    x_grid,mixed_lorenz(x_grid,find_epsilon_simple(World,1000,0.6),0.6),...
    Welt_2002_kaempke_neu.share_pop,Welt_2002_kaempke_neu.cumulated_dist_vector,'.',...
    x_grid,mixed_lorenz(x_grid,find_epsilon_simple(Welt_2002_kaempke_neu,1000,0.6),0.6))
str = "Welt 2016";
dim_1 = [.15 .53 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 12;
box_1.LineStyle = 'None';

epsilon_str =   "G = 0.18";
dim_2 = [0.15 0.49 0 0];
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on');
box_2.FontSize = 12;
box_2.LineStyle = 'None';

str = "Welt 2002";
dim_3 = [.15 .44 0 0];
box_3 = annotation('textbox',dim_3,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_3.FontSize = 12;
box_3.LineStyle = 'None';

epsilon_str = "G = 0.12"
dim_4 = [0.15 0.40 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
xlabel("Cumulative Population Share") ;
ylabel("Cumulative Income Share");
legend('Income Data World Bank 2002','Mixed Lorenz Curve 2002','Income Data World Bank 2016','Mixed Lorenz Curve 2002','Location','Northwest');
legend('show');
xlim([0 1])
ylim([0 1])
grid on
print('Figure_7', '-depsc', '-r900');