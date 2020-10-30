%-------------------------------------------------------------------------------
% pdf_mpc package: Example 1 - control of a crane.
%-------------------------------------------------------------------------------
% Definition of p_ode
%-------------------------------------------------------------------------------
p_ode.tau=0.5;
p_ode.rk_order=4;
p_ode.x0=[0;0;0;0];
p_ode.u0=0;
p_ode.w=[1;-0.2;-0.2];
%-------------------------------------------------------------------------------
% Definition of p_uparam
%-------------------------------------------------------------------------------
p_uparam.nu=1;
p_uparam.Np=20;
p_uparam.Ifree=[1;2;3;10];
p_uparam.R=compute_R(p_uparam.Ifree,...
    p_uparam.Np,p_uparam.nu);
p_uparam.np=size(p_uparam.R,2);
p_uparam.p=0.13*ones(p_uparam.np,1);
p_uparam.pmin=-30*ones(size(p_uparam.R,2),1);
p_uparam.pmax=+30*ones(size(p_uparam.R,2),1);
%-------------------------------------------------------------------------------
% Definition of p_ocp
%-------------------------------------------------------------------------------
p_ocp.Q=diag([1e8;1e4;1;1]);
p_ocp.R=1e2;
p_ocp.M=1e4;
p_ocp.rd=1;
p_ocp.theta_max=0.0015;
p_ocp.thetap_max=2*pi/30;
%-------------------------------------------------------------------------------
% Create the param strcurure 
%-------------------------------------------------------------------------------
[param,flag,message,teval]=create_solution(p_ode,p_uparam,p_ocp,1);
%-------------------------------------------------------------------------------
% Closed-loop simulation
%-------------------------------------------------------------------------------
tsim=400;param.Nev=1300;
[tt,xx,uu,tt_exec,ntsim]=initialize(tsim,param);
rrd=zeros(ntsim,1);
param=update_trust_region_parameters(param,[2,0.5]);
param.ode.rk_order=1;
subset=[1];
for i=1:length(tt)-1
    disp(i/ntsim);
    param=user_sim(tt,i,param);
    [param,u,u_sol,tt_exec(i)]=pdf_mpc(xx(i,:)',param);
    uu(i,:)=u';
    rrd(i)=param.ocp.rd;
    xx(i+1,:)=one_step(xx(i,:)',u,p_ode);
end
rrd(i+1)=rrd(i);
%-------------------------------------------------------------------------------
user_plot;
%-------------------------------------------------------------------------------
