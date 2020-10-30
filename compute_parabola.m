%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function sc=compute_parabola(sc_past,param)
coder.allowpcode('plain');
sc=sc_past;
sc.pbarmin=max(sc.pmin,sc.p-sc.alpha);
sc.pbarmax=min(sc.pmax,sc.p+sc.alpha);
sc.pc=(sc.pbarmin+sc.pbarmax)/2;
sc.beta=(sc.pbarmax-sc.pbarmin)/2;
%--------------------------------------------------------
[sc.Jpbarmin,sc.gpbarmin]=BBS(sc.pbarmin,param);
[sc.Jpc,sc.gpc]=BBS(sc.pc,param);
[sc.Jpbarmax,sc.gpbarmax]=BBS(sc.pbarmax,param);
sc.aJ=(sc.Jpbarmin+sc.Jpbarmax)/2-sc.Jpc;
sc.bJ=(sc.Jpbarmax-sc.Jpbarmin)/2;
sc.cJ=sc.Jpc;
sc.ag=(sc.gpbarmin+sc.gpbarmax)/2-sc.gpc;
sc.bg=(sc.gpbarmax-sc.gpbarmin)/2;
sc.cg=sc.gpc;
%--------------------------------------------------------
if (abs(sc.aJ)>10*eps)
    sc.ps_J=sc.pc-(sc.beta*sc.bJ)/(2*sc.aJ);
elseif (sc.bJ<=0)
    sc.ps_J=inf;
else
    sc.ps_J=-inf;
end
sc.ps_J_star=min(sc.pbarmax,max(sc.pbarmin,sc.ps_J));
inter=(sc.ps_J_star-sc.pc)/sc.beta;
sc.qJstar=sc.aJ*inter^2+sc.bJ*inter+sc.cJ;
lesJ=[sc.Jpbarmin;sc.Jpbarmax;sc.qJstar];
lesp=[sc.pbarmin;sc.pbarmax;sc.ps_J_star];
[sc.qJmin,ind]=min(lesJ);
sc.pJmin=lesp(ind);
[sc.qJmax,ind]=max(lesJ);
sc.pJmax=lesp(ind);
%--------------------------------------------------------
if (abs(sc.ag)>10*eps)
    sc.ps_g=sc.pc-(sc.beta*sc.bg)/(2*sc.ag);
elseif (sc.bg<=0)
    sc.ps_g=inf;
else
    sc.ps_g=-inf;
end
sc.ps_g_star=min(sc.pbarmax,max(sc.pbarmin,sc.ps_g));
inter=(sc.ps_g_star-sc.pc)/sc.beta;
sc.qgstar=sc.ag*inter^2+sc.bg*inter+sc.cg;
lesg=[sc.gpbarmin;sc.gpbarmax;sc.qgstar];
lesp=[sc.pbarmin;sc.pbarmax;sc.ps_g_star];
[sc.qgmin,ind]=min(lesg);
sc.pgmin=lesp(ind);
[sc.qgmax,ind]=max(lesg);
sc.pgmax=lesp(ind);
%--------------------------------------------------------
return


