function y = generate_EU_today_EUSILC()
dta = readtable("EUSILC_EU_Today.xls");

pop_vector = 0:0.1:1;
for i = 1 : size(dta,1)
    income = 0.01* [0,dta.ErstesDezil(i),dta.ZweitesDezil(i),dta.DrittesDezil(i),dta.ViertesDezil(i),...
        dta.F_nftesDezil(i),dta.SechstesDezil(i),dta.SiebtesDezil(i),dta.AchtesDezil(i),dta.NeuntesDezil(i),dta.ZehntesDezil(i)];
    bip = 10^7 * dta.BIPInMioEuro(i);
    pop_size = dta.x2016(i);
    EU_today(i) = State(dta.GEO_QUANTILE(i),income,0,pop_vector,2016,bip,pop_size)
    
end
%y = EU_today
y = common_distribution(EU_today, "EU_Today");