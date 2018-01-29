data = xlsread("ilc_di01.xls","A12:K43");
[~,countries,~] = xlsread("ilc_di01.xls","A12:A43");
countries = string(countries);
share_pop = 0 : 0.1 :1;
for i = 1: size(data,1)
    
    EU_SILC_2015(i) = Equity(countries(i),[0,data(i,:)],share_pop);
    
    
end

EU_SILC_2015_gini = zeros(length(EU_SILC_2015),2);

for i = 1: size(data,1)
    
    EU_SILC_2015_gini(i,:) = find_epsilon_standard(EU_SILC_2015(i),0.6);
    
    
end
size(data) 
size(EU_SILC_2015_gini)
EU_SILC_2015_gini = [countries,EU_SILC_2015_gini]
%%
names_EU_SILC = ["Belgium","Bulgaria","Czech Republic","Denmark","Germany","Estonia","Ireland","Greece","Spain","France","Croatia",...
    "Italy","Cyprus","Latvia","Lithuania","Luxembourg","Hungary","Netherlands","Austria","Poland","Portugal","Romania",...
    "Slovenia","Slovak Republic","Finland","Sweden","United Kingdom","Iceland","Norway","Switzerland","Serbia","Turkey"];

wbd_data = generate_all_countries();
for i = 1 : length(names_EU_SILC)
    wbd_EU(i) = wbd_data(find_index(wbd_data,names_EU_SILC(i)));
end

gini_EU_wbd = zeros(length(wbd_EU),3);
for i = 1 : length(names_EU_SILC)
     gini_EU_wbd(i,1:2) = find_epsilon_standard(wbd_EU(i),0.6);
     gini_EU_wbd(i,3) = wbd_EU(i).year_of_data;
end 

gini_EU_wbd = [names_EU_SILC',gini_EU_wbd];


%% xlswrite("EU_SILC_WBD.xls",[EU_SILC_2015_gini,gini_EU_wbd])
