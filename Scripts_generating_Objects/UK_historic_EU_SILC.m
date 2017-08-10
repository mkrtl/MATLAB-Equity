% Generate historic data of UK out of EU-SILC-Data

i = 2;
% First line filled with data

while xlsread('Data_FR_IT_UK_DE.xls','UK',join(['M', num2str(i)])) > 0 


       dist_vector = [0,xlsread('Data_FR_IT_UK_DE.xls','UK', join(['B',num2str(i),':K',num2str(i)]))]'/100 ;%income
       
       gini = xlsread('Data_FR_IT_UK_DE.xls', 'UK' ,join(['M',num2str(i)]) );                   % World Bank's Gini index
       
       year_of_data = xlsread('Data_FR_IT_UK_DE.xls','UK',join(['A', num2str(i)]));              %Year of WBD Data 
       
       GDP = 0;
       % GDP of country
       
       total_pop = 0;
       % Total population
       share_pop = [0;0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;1];
       % Share of population, which is fixed for all data

       UK(i-1) = State('UK', dist_vector , gini /100 ,share_pop, year_of_data, GDP, total_pop); 

       
       i=i+1;
       % Increase the numerator i by one.   
end
