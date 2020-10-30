%-------------------------------------------------------------------------------
%pdf_mpc package: Example 1 - Definition of the user_control_profile map
%-------------------------------------------------------------------------------
function u_profile=user_control_profile(p,p_ode,p_uparam)
    u_profile=reshape(p_uparam.R*p,...
        p_uparam.Np,p_uparam.nu);
end
%-------------------------------------------------------------------------------