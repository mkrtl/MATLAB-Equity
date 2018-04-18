% Script to produce made up example plots for Paper by Herlyn and
% Radermacher
a = 0.6;

x_example = [0; 0.5; 1];
y_example = [0; 0.1; 1];
x = 0:0.001:1;
diagonal = x;

f1 = figure;
%hold on
%plot(x,diagonal,'-','DisplayName','Diagonale',x_example,y_example,'-','DisplayName','Beispieldaten');
plot(x,diagonal,'-k','DisplayName','Diagonal');
hold on 
plot(x_example,y_example,'-','DisplayName','Sample Data');
%plot(x_example,y_example,'-','DisplayName','Beispieldaten');
hold on 

Gini = 1-(2*(0.5*(0.5*0.1)+0.5*0.1+0.5*(0.9*0.5)));
eps = (1-Gini)/(1+Gini); 
plot(x,mixed_lorenz(x,eps,a),'--','DisplayName','Mixed Lorenz Curve');
%fill([x,y_example],[x,mixed_lorenz(x,eps,a)],'b')

epsilon_str = "G = 0.4";
dim_1 = [0.15 0.58 0 0];
box_1 = annotation('textbox',dim_1,'String',epsilon_str, 'FitBoxToText','on');
box_1.FontSize = 12;
box_1.LineStyle = 'None';
xlabel("Cumulative Population Share");
ylabel("Cumulative Income Share");
grid on 
legend('show','location','northwest')
print('-depsc','Figure_3','-r900')

%%%% Density plot %%%%%

xd1 = [0; 0.5];
yd1 = [0.2; 0.2];
xd2 = [0.5; 1];
yd2 = [1.8; 1.8];
f2 = figure
p1 = plot(xd1,yd1,'o-k');
hold on 
p2 = plot(xd2,yd2,'o-k');
hold on
p3 = plot(x,mixed_lorenz_density(x,eps,a),'--');
xlim([0 1]);
ylim([0 2.5]);


epsilon_str = "G = 0.4";
dim_1 = [0.15 0.58 0 0];
box_1 = annotation('textbox',dim_1,'String',epsilon_str, 'FitBoxToText','on');
box_1.FontSize = 12;
box_1.LineStyle = 'None';

xlabel("Cumulative Population Share");
ylabel("Share of Averarge Income");
set(gca, 'YTick', sort([0.2, get(gca, 'YTick')]));
set(gca, 'YTick', sort([1.8, get(gca, 'YTick')]));
grid on 
legend([p2 p3],{'Sample Data','Mixed Lorenz Density'},'location','northwest');
%legend('show','location','northwest');

%saveas(f2,sprintf('Beispieldaten_MixedLorenzdichte.png')    );
%saveas(f2,sprintf('Beispieldaten_MixedLorenzdichte.pdf'));
print('-depsc','Figure_4','-r900')
