%---------------------------------------------------------
% Author : Mazen Alamir
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------
function [J,g]=BBS(eta,param)
coder.allowpcode('plain');
param.ode.x0=param.x0;
ell=param.ell;p=param.p;p(ell)=eta;
[~,xx,uu]=simulate_ol(p,param.ode,param.uparam);
[J,g]=user_ocp(xx,uu,param.ode,param.uparam,param.ocp);
end
%---------------------------------------------------------