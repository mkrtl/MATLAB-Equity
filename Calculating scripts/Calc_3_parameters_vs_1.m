result = zeros(length(wbd_data),6);
names = string();
for i = 1 : length(wbd_data)
    result(i,1:4) = test_minimizer(wbd_data(i));
    result(i,5:6) = find_epsilon_standard(wbd_data(i),0.6);
    names(i) = wbd_data(i).country;
end

xlswrite('Results_comparison_3_parameters_vs_one.xlsx',result,'Tabelle1','B2')
xlswrite('Results_comparison_3_parameters_vs_one.xlsx',names','Tabelle1','A2')

