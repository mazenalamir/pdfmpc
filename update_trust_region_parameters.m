%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function param=update_trust_region_parameters(param_past,beta,varargin)

coder.allowpcode('plain');
param=param_past;
for i=1:length(param.mv)
    param.mv(i).beta_plus=beta(1);
    param.mv(i).beta_moins=beta(2);
    if length(varargin)==1
        lesalpha_min=varargin{1};
        if min(lesalpha_min)<0
            disp('message from update_trust_region_parameters');
            error('alpha_min must be >0');
        end
        if length(lesalpha_min)==1
            param.mv(i).alpha_min=lesalpha_min;
        elseif length(lesalpha_min)==param.np
            param.mv(i).alpha_min=lesalpha_min(i);
        else
            disp('message from update_trust_region_parameters');
            error('bad size of the last argument');
        end
    end
end

