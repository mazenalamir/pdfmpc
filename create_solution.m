%---------------------------------------------------------
% Author : Mazen Alamir
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function [param,flag,message,tc]=create_solution(p_ode,p_uparam,p_ocp,mode)
coder.allowpcode('plain');
deadline = '20-04-2117';
formatIn = 'dd-mm-yyyy';
deadline=datenum(deadline,formatIn);
d=datenum(datetime('today'));
[flag,message]=check_parameters(p_ode,p_uparam,p_ocp);
tc=[];
if (d>deadline)
    flag=0;
    message='licence is no more valid, please renew it on www.mazenalamir.fr';
    param=[];
    error(message);
elseif (flag==0)
    error('There are erros in the definition (see the messages)');
else
    param.pmin=p_uparam.pmin;
    param.pmax=p_uparam.pmax;
    param.p=p_uparam.p;
    param.alpha=0.1*ones(p_uparam.np,1);
    param.ell=1;
    param.uparam=p_uparam;
    param.ode=p_ode;
    if isfield(p_ode,'w')
        if ~isempty(p_ode.w)
            param.ode.w=0*p_ode.w;
        end
    end
    param.ocp=p_ocp;
    param.x0=param.ode.x0;
    mv=create_mv(param.p,param.pmin,param.pmax,param.alpha);
    param.mv=mv;
    param.compiled=1;
    param.Nev=200;
    param.Niter=1;
    param.np=length(param.p);
    disp('message from create_param')
    disp('*****************************')
    disp(message);
    disp('*****************************')
    np=length(param.p);
    if (mode==1)
        tmv=coder.typeof(mv);
        tNev=coder.typeof(1.0,1,0);
        tNiter=coder.typeof(1.0,1,0);
        tparam=coder.typeof(param);
        tsubset=coder.typeof(1,[np 1],[1 0]);
        codegen update_mv -args {tmv,tsubset,tparam} -o controller -report
        codegen BBS -args {tNev,tparam} -o BBS_check -report
        t1=clock;
        for i=1:1000
            BBS(1,param);
        end
        tc=max((clock-t1)/1000);
        disp(['estimated time for a single evaluation = ',num2str(1.2*tc*1000),' micro seconds']);
        tc=tc/1000;
        delete('BBS_check.*');
    end
end
end