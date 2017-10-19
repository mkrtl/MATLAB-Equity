% Plot Welt 2002
    
    plot(mixed_lorenz_Welt_2002_kaempke_neu.share_pop,Welt_2002_kaempke_neu.cumulated_dist_vector,'.')
    
    xlabel("Bevölkerungsanteil x") ;
    ylabel("Kumuliertes Einkommen");
    legend('Empirische Verteilung der Einkommen weltweit im Jahr 2002');
    legend('show');
    
    grid on 
    print('Welt_2002.png', '-dpng', '-r300');