%---------------------------------------------------------
function xplus=one_step(x,u,p_ode)
coder.allowpcode('plain');
    h=p_ode.tau;
    if (p_ode.rk_order==1)
        xplus=x+h*user_ode(x,u,p_ode);
    elseif (p_ode.rk_order==2)
        k1=user_ode(x,u,p_ode);
        k2=user_ode(x+0.5*k1*h,u,p_ode);
        xplus=x+k2*h;
    else
        k1=user_ode(x,u,p_ode);
        k2=user_ode(x+0.5*k1*h,u,p_ode);
        k3=user_ode(x+0.5*k2*h,u,p_ode);
        k4=user_ode(x+k3*h,u,p_ode);
        xplus=x+h*(k1+2*(k2+k3)+k4)/6;
    end
        
end