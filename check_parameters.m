%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function [flag,message]=check_parameters(p_ode,p_uparam,p_ocp)
coder.allowpcode('plain');
    flag=1;i=0;
    message{1}='Seems ok';
    if (isfield(p_ode,'tau')==0)
        flag=0;i=i+1;
        message{i}='missing p_ode.tau : sampling period for the system';
    end
    if (isfield(p_ode,'rk_order')==0)
        flag=0;i=i+1;
        message{i}='missing p_ode.rk_order : order of Runge-Kutta method';
    elseif (min(abs(p_ode.rk_order-[1;2;4]))>0)
        flag=0;i=i+1;
        message{i}='invalid p_ode.rk_order : Should be in {1,2,4}';
    end
    if (isfield(p_ode,'x0')==0)
        flag=0;i=i+1;
        message{i}='missing p_ode.x0 : the inital state';
    end
    if (isfield(p_ode,'u0')==0)
        flag=0;i=i+1;
        message{i}='missing p_ode.u0 : Initial actuator position';
    end
    if (isfield(p_uparam,'nu')==0)
        flag=0;i=i+1;
        message{i}='missing p_uparam.nu : the dimension of u';
    end
    if (isfield(p_uparam,'pmin')==0)
        flag=0;i=i+1;
        message{i}='missing p_uparam.pmin : lower bound on p';
    end
    if (isfield(p_uparam,'pmax')==0)
        flag=0;i=i+1;
        message{i}='missing p_uparam.pmax : upper bound on p';
    end
    if (isfield(p_uparam,'np')==0)
        flag=0;i=i+1;
        message{i}='missing p_uparam.np : dimension of p';
    end
    if (isfield(p_uparam,'p')==0)
        flag=0;i=i+1;
        message{i}='missing p_uparam.p : Initial value for p';
    end    
    
    for ind=1:length(message)
        disp(message{ind})
    end
end