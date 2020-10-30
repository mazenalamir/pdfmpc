%-------------------------------------------------------------------------------
% pdf_mpc package: Example 1 - Definition of the user_ode map
%-------------------------------------------------------------------------------
function xdot=user_ode(x,u,p_ode)
% x=(r,rp,theta,thetap)
w=p_ode.w;
m=200*(1+w(1));
M=1500;frot_theta=1e5*(1+w(2));frot_r=10*(1+w(3));
L=100;g=0.81;
th=x(3);thp=x(4);
c=cos(th);
s=sin(th);
xdot=zeros(4,1);
xdot(1)=x(2);
xdot(2)=(u+m*g*c*s+m*L*s*thp^2-frot_r*x(2))/(M+m*(1-c^2));
xdot(3)=x(4);
xdot(4)=(-u*c-m*L*thp^2*c*s-(M-m)*g*s-frot_theta*thp)/((M+m*s^2)*L);
return
%-------------------------------------------------------------------------------