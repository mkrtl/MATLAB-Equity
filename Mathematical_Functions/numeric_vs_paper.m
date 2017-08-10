function numeric_vs_paper(a,b,m,epsilon_1,epsilon_2)

% Plots the merged lorenz curves calculated by a numerical approach and by
% the analytical approach of Mr. Kämpke described in "A straightforward
% calculus of Lorenz Curves" in one canvas. 

paper_curve = merged_lorenz_curve_paper_simple(m,b,epsilon_1,epsilon_2,a);
numeric_curve = merged_lorenz_curve(a,b,m,epsilon_1,epsilon_2);
plot(numeric_curve(1,:),numeric_curve(2,:),'b',paper_curve(1,:),paper_curve(2,:),'g') 
legend('Numerical approach' , 'Paper Approach')