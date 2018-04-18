function y = generate_all_countries_historic_gui()

% Generates an array of objects of state class with all the World Bank Data
% and calls this array wbd_data_historic. To find index of state, use function find_index.

% !!! To add additional countries and regions to GUI take a look below!!!

T = readtable('Data_WBD_historic.xlsx');

% Create MATLAB-table 

size_T = size (T);
% Size of the table


for i = 1 : size_T(1)
       
       dist_vector = [0,T.x0_10(i),T.x10_20(i),T.x20_40(i),T.x40_60(i),T.x60_80(i),...
                        T.x80_90(i),T.x90_100(i)]'/100; %income
       
       wbd_gini = T.GINIIndex(i)/100;                   % World Bank's Gini index
       
       year_of_data = T.Time(i);                        % Year of WBD Data 
       
       country = char(T.CountryName(i));                % Name of country
       
       GDP = T.GDP_constant2010US__(i);                 % GDP of country
       
       total_pop = T.Population(i);                     % Total population

       share_pop = [0;0.1;0.2;0.4;0.6;0.8;0.9;1];       % Share of population, 
                                                        %which is fixed for all data
       
       y(i) = State(country, dist_vector,... 
                                    wbd_gini, share_pop, year_of_data, GDP, total_pop); 
       
                                                        % Generates State object 
       
end 

% Stop Excel process, which sometimes stays open despite ended program: 

system('taskkill /F /IM EXCEL.EXE');
% !!! As an example, the EU is added to the available countries in GUI

EU = generate_EU();
name_EU = "EU";
epsilon_EU = find_epsilon_standard(EU,0.6);
gini_EU = (1-epsilon_EU)/(1+epsilon_EU);
auxiliary_object = State(name_EU,EU.dist_vector,gini_EU, EU.share_pop,2017,1,1);
y(end + 1) =  auxiliary_object;