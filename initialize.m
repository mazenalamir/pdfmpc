%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function [tt,xx,uu,tt_exec,ntsim]=initialize(tsim,param)
coder.allowpcode('plain');
ntsim=fix(tsim/param.ode.tau)+1;
xx=zeros(ntsim,length(param.x0));
tt=(0:1:ntsim-1)'*param.ode.tau;
tt_exec=zeros(ntsim,1);
uu=zeros(ntsim,param.uparam.nu);
xx(1,:)=param.x0';
end
