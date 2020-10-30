%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------
function [param,u,u_sol,tc]=pdf_mpc(x0,param,varargin)
coder.allowpcode('plain');
if (length(varargin)==1)
    subset=varargin{1};
else
    subset=(1:1:param.np)';
end
param.x0=x0;
t0=clock;
if (param.compiled==1)
    [u_sol,p_sol]=controller(param.mv,subset,param);
else
    [u_sol,p_sol]=update_mv(param.mv,subset,param);
end
u=u_sol(1,:)';
 tc=etime(clock,t0);
 param.ode.u0=u_sol(1,:)';
end