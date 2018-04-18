% Plot Gini vs. Income 

clear all;

wbd_data = generate_all_countries;
data_matrix = zeros(length(wbd_data),2); 
name_string = strings(length(wbd_data),1);

for i = 1 : length(wbd_data)
    data_matrix(i,1) = wbd_data(i).gini_data;
    data_matrix(i,2) = wbd_data(i).gdp_per_head;
    name_string(i) = wbd_data(i).country; 
end 

interesting_countries = ["Sweden","Germany","United States","Russian Federation","Venezuela, RB","Haiti","China","Norway","Namibia"];
index_interesting = zeros(length(interesting_countries),1);
for i = 1 : length(index_interesting)
    index_interesting(i) = find_index(wbd_data,interesting_countries(i));
end


dx = 0.006;
dy = 500;
 % displacement so the text does not overlay the data points
%interesting_countries = ["Sweden","Germany","United States","Russian Federation","Venezuela, RB","Haiti","China","Norway","Namibia"];

interesting_countries = {'Schweden','Deutschland','USA','Russland','Venezuela','Haiti','China','Norwegen','Namibia'};

s = scatter(data_matrix(:,1),data_matrix(:,2));
s.MarkerEdgeColor = 'b';
s.MarkerFaceColor = [0 0.5 0.5];
grid on
xlabel("Gini-Index")
ylabel("Pro-Kopf-Einkommen in 2010 US-Dollar")
dim_1 = [0.55 .77 0 0];
str = {'Weltbank', 'aktuellster Datensatz 2016'};
box_1 = annotation('textbox',dim_1,'String',str, 'FitBoxToText','on', 'Interpreter','none','FontName','Helvetica');
box_1.FontSize = 10;
% ,'.','MarkerSize',20)
%xlabel("Gini-
text(data_matrix(index_interesting,1)+dx, data_matrix(index_interesting,2)+dy, interesting_countries,'FontWeight','bold','FontSize',9);

 
print('Gini_vs_income','-dpng','-r300');