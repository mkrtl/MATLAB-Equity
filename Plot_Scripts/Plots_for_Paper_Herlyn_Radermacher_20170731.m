% Script to produce example plots for Paper by Herlyn and Radermacher
% Task 1:   Countries with same Gini should have same data points
%           three comparison plots with three countries of same Gini each

%generate_all_countries

% Get the Ginis out into an array
for i=1:length(wbd_data)
    wbd_ginis(i) = wbd_data(i).gini_data;
    wbd_ginis_round(i) = round(wbd_ginis(i),2);
    state_index(i) = i;
end

G27 = ["Finland", "Sweden", "Belgium"];
G33 = ["France", "Ethiopia", "Canada"];
G41 = ["Uganda", "United States", "Russian Federation"];
G50 = ["Rwanda", "Chile", "Honduras"];
G60 = ["Botswana", "Haiti", "Namibia"];

%% sch�ner name 
%%% G27 %%%%
for i=1:length(G27)
    state_index = find_index(wbd_data,G27(i));
    G27_states(i) = wbd_data(state_index);
end

f = figure;
%colours = ['g', 'k', 'b'];
colours = {[0 0 0], [0 0.65 0.5], [.8 .09 .11]};
for i=1:length(G27_states)
    %eps=epsilon(G27_states(i));
    eps=G27_states(i).epsilon;
    name = sprintf('%s %i',G27_states(i).country, G27_states(i).year_of_data)
%    f=@(x) a* (1-(1-x).^eps) + (1-a) * x.^(1/eps);
%    y=plot(0:0.01:1,f(0:0.01:1),G27_states(i).share_pop,G27_states(i).cumulated_dist_vector,'+','DisplayName',G27_states(i).country);
    %f(1)=plot(G27_states(i).share_pop,G27_states(i).cumulated_dist_vector,strcat('x',colours(i)),'DisplayName',G27_states(i).country);
    f(1)=plot(G27_states(i).share_pop,G27_states(i).cumulated_dist_vector,'x','Color',colours{i},'MarkerSize',10,'DisplayName',name);
    hold on
end 
legend('show','Location','northwest');
xlabel("Cumulative Population Share");
ylabel("Cumulative Income Share");
grid on 
epsilon_str = "G = 0.27"
dim_4 = [0.15 0.40 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
print('Figure8_1','-depsc','-r900')
hold off
%saveas(f(1),sprintf('Gini27_comparison.png'))
%saveas(f(1),sprintf('Gini27_comparison.pdf'))

%%%%%%%%%%%%%%%%%% End G27 %%%%%%%%
%% section 2 
%%% G33 %%%%
figure;
for i=1:length(G33)
    state_index = find_index(wbd_data,G33(i));
    G33_states(i) = wbd_data(state_index);
end

for i=1:length(G33_states)
    eps=G33_states(i).epsilon;
    
    name = sprintf('%s %i',G33_states(i).country, G33_states(i).year_of_data)
    f(2)=plot(G33_states(i).share_pop,G33_states(i).cumulated_dist_vector,'x','Color',colours{i},'MarkerSize',10,'DisplayName',name);
    hold on
end 
legend('show','Location','northwest');
xlabel("Cumulative Population Share");
ylabel("Cumulative Income Share");
grid on 
epsilon_str = "G = 0.33"
dim_4 = [0.15 0.40 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
print('Figure8_2','-depsc','-r900')
hold off
%saveas(f(2),sprintf('Gini33_comparison.png'))
%saveas(f(2),sprintf('Gini33_comparison.pdf'))

%%%%%%%%%%%%%%%%%% End G33 %%%%%%%%
figure;
%%% G41 %%%%
for i=1:length(G41)
    state_index = find_index(wbd_data,G41(i));
    G41_states(i) = wbd_data(state_index);
end

for i=1:length(G41_states)
    eps=G41_states(i).epsilon;
    name = sprintf('%s %i',G41_states(i).country, G41_states(i).year_of_data)
    f(3)=plot(G41_states(i).share_pop,G41_states(i).cumulated_dist_vector,'x','Color',colours{i},'MarkerSize',10,'DisplayName',name);
    hold on
end 
legend('show','Location','northwest');
epsilon_str = "G = 0.41"
dim_4 = [0.15 0.40 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
xlabel("Cumulative Population Share");
ylabel("Cumulative Income Share");
grid on 
print('Figure8_3','-depsc','-r900')
hold off
%saveas(f(3),sprintf('Gini41_comparison.png'))
%saveas(f(3),sprintf('Gini41_comparison.pdf'))
%%%%%%%%%%%%%%%%%% End G41 %%%%%%%%
figure;
%%% G50 %%%%
for i=1:length(G50)
    state_index = find_index(wbd_data,G50(i));
    G50_states(i) = wbd_data(state_index);
end

for i=1:length(G50_states)
    eps=G50_states(i).epsilon;
    name = sprintf('%s %i',G50_states(i).country, G50_states(i).year_of_data)
    f(4)=plot(G50_states(i).share_pop,G50_states(i).cumulated_dist_vector,'x','Color',colours{i},'MarkerSize',10,'DisplayName',name);
    hold on
end 
legend('show','Location','northwest');
epsilon_str = "G = 0.50"
dim_4 = [0.15 0.40 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
xlabel("Cumulative Population Share");
ylabel("Cumulative Income Share");
grid on 
print('Figure8_4','-depsc','-r900')
hold off
%saveas(f(4),sprintf('Gini50_comparison.png'))
%saveas(f(4),sprintf('Gini50_comparison.pdf'))
%%%%%%%%%%%%%%%%%% End G50 %%%%%%%%
figure;
%%% G60 %%%%
for i=1:length(G60)
    state_index = find_index(wbd_data,G60(i));
    G60_states(i) = wbd_data(state_index);
end

for i=1:length(G60_states)
    eps=G60_states(i).epsilon;
    name = sprintf('%s %i',G60_states(i).country, G60_states(i).year_of_data);
    f(5)=plot(G60_states(i).share_pop,G60_states(i).cumulated_dist_vector,'x','Color',colours{i},'MarkerSize',10,'DisplayName',name);
    hold on
end 
legend('show','Location','northwest');
epsilon_str = "G = 0.60"
dim_4 = [0.15 0.40 0 0];
box_4 = annotation('textbox',dim_4,'String',epsilon_str, 'FitBoxToText','on');
box_4.FontSize = 12;
box_4.LineStyle = 'None';
xlabel("Cumulative Population Share");
ylabel("Cumulative Income Share");
grid on
print('Figure8_5','-depsc','-r900')
hold off
%saveas(f(5),sprintf('Gini60_comparison.png'))
%saveas(f(5),sprintf('Gini60_comparison.pdf'))

%%%%%%%%%%%%%%%%%% End G60 %%%%%%%%

states_matrix = [G27_states;G33_states;G41_states;G50_states;G60_states];