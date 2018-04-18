% Plot Welt 2002
% Ordentliches epsilon finden und einbauen!!!

%plot(wbd_data(find_index(wbd_data,"China")).share_pop,wbd_data(find_index(wbd_data,"China")).cumulated_dist_vector,'+')
plot(US(1).share_pop,US(1).cumulated_dist_vector,'+')
hold on
plot(0:0.001:1,mixed_lorenz(0:0.001:1,US(1).epsilon_model,0.6));
xlabel("Bevölerungsanteil x") ;
ylabel("Kumuliertes Einkommen");
legend('Daten Weltbank E','Mixed Lorenzkurve K','Location','northwest');
legend('show');
str = ' Deutschland 2012';
dim_1 = [.15 .5 0 0];
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on');
box_1.FontSize = 15;
box_1.LineStyle = 'None';

epsilon_str =   join(['\bf{$\varepsilon = ', num2str(round(US(1).epsilon_model,2)),'$}']);
dim_2 = [0.165 0.43 0 0]
box_2 = annotation('textbox',dim_2,'String',epsilon_str, 'FitBoxToText','on','Interpreter','Latex')
box_2.FontSize = 15;
box_2.LineStyle = 'None';
grid on 
%%
% $x^2+e^{\pi i}$
%print('Deutschland.png', '-dpng', '-r300');
hold off