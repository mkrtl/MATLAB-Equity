function y = generate_EU2001_EUSILC()
% No data for Denmark and Sweden and therefore excluded!

dta = readtable("EU2001_EUSILC.xls");

pop_vector = 0:0.1:1;
for i = 1 : size(dta,1)
    income = [0,dta.ErstesDezil(i),dta.ZweitesDezil(i),dta.DrittesDezil(i),dta.ViertesDezil(i),...
        dta.F_nftesDezil(i),dta.SechstesDezil(i),dta.SiebtesDezil(i),dta.AchtesDezil(i),dta.NeuntesDezil(i),dta.ZehntesDezil(i)];
    bip = dta.BIPInMioEuro(i);
    pop_size = dta.x2001(i);
    EU2001_today(i) = State(dta.GEO_QUANTILE,income,0,pop_vector,2016,bip,pop_size);
    
end
y = common_distribution(EU2001_today, "EU_2002_2016_EUSILC");