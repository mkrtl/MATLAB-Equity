function y = generate_EU2002_today_EUSILC(exclude_Den_Swe)
% Fill in 1 to exclude Denmark and Sweden from cumulation.
dta = readtable("EU2002_heute_EUSILC.xls");

pop_vector = 0:0.1:1;
for i = 1 : size(dta,1)
    income = [0,dta.ErstesDezil(i),dta.ZweitesDezil(i),dta.DrittesDezil(i),dta.ViertesDezil(i),...
        dta.F_nftesDezil(i),dta.SechstesDezil(i),dta.SiebtesDezil(i),dta.AchtesDezil(i),dta.NeuntesDezil(i),dta.ZehntesDezil(i)];
    bip = dta.BIPInMioEuro(i);
    pop_size = dta.x2016(i);
    EU2002_today(i) = State(dta.GEO_QUANTILE,income,0,pop_vector,2016,bip,pop_size);
    
end
if exclude_Den_Swe == 1
    EU2002_today = EU2002_today([1,3:13,15])
end

y = common_distribution(EU2002_today, "EU_2002_2016_EUSILC");