%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------
function f=qJ(sc,p)
coder.allowpcode('plain');
inter=(p-sc.pc)/sc.beta;
f=sc.aJ*inter^2+sc.bJ*inter+sc.cJ;
return