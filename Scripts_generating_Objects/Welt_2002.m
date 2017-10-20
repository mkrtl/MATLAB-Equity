function y = Welt_2002()

cum_dist_vector = xlsread("Welt_gesamt.xls","Tabelle2","H13:H887");
for i = 2 : length(cum_dist_vector)
dist_vector(i) = cum_dist_vector(i)-cum_dist_vector(i-1);
end
dist_vector(1) = cum_dist_vector(1);
dist_vector(length(dist_vector)-2)
y = Equity("Welt_2002",dist_vector',xlsread("Welt_gesamt.xls","Tabelle2","G13:G887"));
