% generate_all_countries.
% Uses the historic dataset and gives back for
% every country only the most recent entry. Resulting vector is called
% wbd_data.
% !! Assumes the entries are ordered by the year of their creation, such that 
% most recent entries are first !!
%% genearate_all_countries_historic
generate_all_countries_historic
%% Find most recent dataset for every country
already_in_wbd_data = string();
% Indicator, if we already have country in wbd_data
wbd_data=[];
% Empty vector for dataset
for i = 1 : length(wbd_data_historic)
    if any (string(wbd_data_historic(i).country) == already_in_wbd_data)
    % Do nothing, if country is already in dataset wbd_data
    else
    % Add the most recent entry, which is the one with the minimal index    
        wbd_data = [wbd_data,wbd_data_historic(min(find_index(wbd_data_historic, string(wbd_data_historic(i).country))))];
        already_in_wbd_data = [already_in_wbd_data,string(wbd_data_historic(i).country)];
    end
end
