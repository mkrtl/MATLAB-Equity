a = plot(0:0.01:1,mixed_lorenz(0:0.01:1,find_epsilon_simple(EU_2002_today,1000,0.6),0.6),EU_2002_today.share_pop,EU_2002_today.cumulated_dist_vector,'+');

saveas(a,'EU_2002_today.png')