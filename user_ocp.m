%-------------------------------------------------------------------------------
% pdf_mpc package: Example 1 - Definition of the user_ocp map
%-------------------------------------------------------------------------------
function [J,g]=user_ocp(xx,uu,p_ode,p_uparam,p_ocp)
J=0;xd=[p_ocp.rd;0;0;0];
for i=1:p_uparam.Np
    if i==1
        du=uu(1)-p_ode.u0;
    else
        du=uu(i)-uu(i-1);
    end
    e=xx(i+1,:)'-xd;
    J=J+(e'*p_ocp.Q*e+p_ocp.R*uu(i)^2+p_ocp.M*du^2);
end
h1=max(xx(:,3)-p_ocp.theta_max);
h2=max(-xx(:,3)-p_ocp.theta_max);
h3=max(xx(:,4)-p_ocp.thetap_max);
h4=max(-xx(:,4)-p_ocp.thetap_max);
g=max([h1;h2;h3;h4]);
end
%-------------------------------------------------------------------------------