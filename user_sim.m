%-------------------------------------------------------------------------------
% pdf_mpc package: Example 1 - time varying param.ocp.rd
%-------------------------------------------------------------------------------
function param=user_sim(tt,i,param_past)
param=param_past;
cond1=(tt<=tt(end)/3);
cond2=(tt>tt(end)/3).*(tt<=tt(end)*2/3);
cond3=(tt>tt(end)*2/3).*(tt<=tt(end));
param.ocp.rd=cond1(i)-3*cond2(i)+3*cond3(i);
end
%-------------------------------------------------------------------------------