result = zeros(152,4);
names = strings(152,1);
for i = 1 : length(wbd_data)
    names(i) = wbd_data(i).country;
    result(i,1) = find_epsilon_pareto(wbd_data(i));
    result(i,2) = find_epsilon_polynomial(wbd_data(i)); 
    result(i,3) = find_epsilon_mixed(wbd_data(i)); 
    result(i,4) = wbd_data(i).epsilon;
end
xlswrite('fitresult.xls',result,'Tabelle1','B2');
xlswrite('fitresult.xls',names,'Tabelle1','A2');
