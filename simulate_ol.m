%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function [tt,xx,uu]=simulate_ol(p,p_ode,p_uparam)
coder.allowpcode('plain');
x0=p_ode.x0;nx=length(x0);
uu=user_control_profile(p,p_ode,p_uparam);
xx=zeros(p_uparam.Np+1,nx);
xx(1,:)=reshape(x0,1,nx);
tt=(0:1:p_uparam.Np)'*p_ode.tau;
for i=1:p_uparam.Np
    xx(i+1,:)=one_step(xx(i,:)',uu(i,:)',p_ode);
end
end