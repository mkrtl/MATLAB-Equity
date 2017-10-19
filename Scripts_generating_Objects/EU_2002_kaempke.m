% Generates EU of 2002 with data from Kämpke

A = readtable('Kämpke_2002_EU.xlsx');
Einkommen = A.Einkommen;
Einkommen = Einkommen(Einkommen ~=0);
Bev = A.Bev_lkerung;
Bev = Bev(Bev ~=0);
x = 0:0.001:1;
EU2002_kaempke = Equity("EU_2002_kaempke",[0;diff(Einkommen)],Bev);
