%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function f=qg(sc,p)
coder.allowpcode('plain');
inter=(p-sc.pc)/sc.beta;
f=sc.ag*inter^2+sc.bg*inter+sc.cg;
return