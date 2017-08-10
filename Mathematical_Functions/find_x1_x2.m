function y=find_x1_x2(x,a,epsilon_1,epsilon_2,m,b)
% Finds the x_1 and x_2 value for merged Lorenz curves according to paper 
% "A straightforward and versatile calculus for income inequality"
% y = solve((b/m)*mixed_lorenz_density(x_1/ m,epsilon_1,a) == (1-b)/(1-m)*mixed_lorenz_density((x-x_1)/(1-m),epsilon_2,a),x_1,'PrincipaValue',true, 'IgnoreAnalyticConstraints', true, [0 1])
% Does not work properly!!!
fsolve((b/m)*(1-a)*(1/epsilon_1)*x.^((1/epsilon_1)-1)+a*epsilon_1*(1-x).^(epsilon_1-1) - (1-b)/(1-m)*(1-a)*(1/epsilon_2)*x.^((1/epsilon_2)-1)+a*epsilon_2*(1-x).^(epsilon_2-1),x_1)
end


