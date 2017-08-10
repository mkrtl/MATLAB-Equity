% Plot Welt 2002
% Ordentliches epsilon finden und einbauen!!!
set(0,'defaulttextInterpreter','none')
%plot(wbd_data(find_index(wbd_data,"Brazil")).share_pop,wbd_data(find_index(wbd_data,"Brazil")).cumulated_dist_vector,'+')
hold on
plot(0:0.001:1,0:0.001:1,'red');
legend('Mixed Lorenzkurve','Location','northwest');
legend('show');
xlabel('Bevölkerungsanteil x')
ylabel('Einkommensanteil')
dim_1 = [.15 .64 0 0];
box_1 = annotation('textbox',dim_1,'String','Gleichverteilung', 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 15;
box_1.LineStyle = 'None';

dim_2 = [0.15 0.57 0 0]
box_2 = annotation('textbox',dim_2,'String','Gini = 0', 'FitBoxToText','on')
box_2.FontSize = 15;
box_2.LineStyle = 'None';
grid on 
%%
% $x^2+e^{\pi i}$
print('Gleichverteilung.png', '-dpng', '-r300');



