%Generates data to validate methods with regard to old results.

pos = {'A','B','C','D','E','F','G','H','I','J'};

for i = 2:16 % 16 is length of Excel table. 
  

       dist_vector = xlsread('verification_data.xlsx','Tabelle1',[pos{4} num2str(i) ':' ,pos{10} num2str(i)]);%income
       
       wbd_gini = xlsread('verification_data.xlsx','Tabelle1',[pos{3} num2str(i)]);                %WBD Gini coefficient 
       
       year_of_data=xlsread('verification_data.xlsx','Tabelle1',[pos{2} num2str(i)]);              %Year of WBD Data 
       
       [num,txt,raw]=xlsread('verification_data.xlsx','Tabelle1',[pos{1} num2str(i)]);             %Method to read text out of excel file
       
       dist_vector=[0,dist_vector];
       
       examples(i-1)=State(char(txt),dist_vector,wbd_gini,year_of_data);   
       %Generates state object with state name as string
end 

