wbd_data = generate_all_countries_historic();
result = zeros(length(wbd_data),6);
names = strings(length(wbd_data),1);
for i = 1 : length(wbd_data)
    result(i,1:4) = test_minimizer(wbd_data(i));
    result(i,5:6) = find_epsilon_standard(wbd_data(i),0.6);
    names(i) = join([wbd_data(i).country," ",num2str(wbd_data(i).year_of_data)]);
end
header = ["Land und Jahr","a-Wert","Epsilon-Pareto","Epsilon-Polynomial","MSE 3 Parameter","Epsilon-Standard","MSE Standard"];
xlswrite('TR_result.xlsx',header,'Tabelle1','A1')
xlswrite('TR_result.xlsx',result,'Tabelle1','B2')
xlswrite('TR_result.xlsx',names,'Tabelle1','A2')

