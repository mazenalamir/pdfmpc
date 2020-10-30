%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

function [sc,lesp,lesalpha]=update_sc(sc_past,param,Niter)
coder.allowpcode('plain');
sc=sc_past;[Jcurrent,gcurrent]=BBS(sc.p,param);
lesp=zeros(Niter,1);lesalpha=lesp;
for i=1:Niter
    lesp(i)=sc.p;lesalpha(i)=sc.alpha;
    sc=compute_parabola(sc,param);
    if (sc.qgmax<=0)
        pcand=sc.pJmin;[Jcand,gcand]=BBS(pcand,param);
        Cond=(((Jcand<Jcurrent)&&(gcand<=0))||...
                ((Jcand<=Jcurrent)&&(gcand<0)));
    elseif (sc.qgmin>0)
        pcand=sc.pgmin;[Jcand,gcand]=BBS(pcand,param);
        Cond=(gcand<gcurrent);
    else
        sc=compute_Zg(sc);
        if (sc.ngz==1)
               vp=[sc.Z(1);sc.Z(2);min(sc.Z(2),max(sc.Z(1),sc.pJmin))];
               vJ=zeros(3,1);
               vJ(1)=qJ(sc,vp(1));vJ(2)=qJ(sc,vp(2));vJ(3)=qJ(sc,vp(3));
               if (abs(min(vJ)-max(vJ))<1e1*eps)
                    vg=zeros(3,1);
                    vg(1)=qg(sc,vp(1));vg(2)=qg(sc,vp(2));vg(3)=qg(sc,vp(3));
                    [~,ind]=min(vg);pcand=vp(ind);
               else
                   [~,ind]=min(vJ);pcand=vp(ind);
               end
               [Jcand,gcand]=BBS(pcand,param);
        else
            pcand=zeros(2,1);Jcand=zeros(2,1);
            for j=1:2
               vp=[sc.Z(2*(j-1)+1);sc.Z(2*j);...
                   min(sc.Z(2*j),max(sc.Z(2*(j-1)+1),sc.pJmin))];
               vJ=zeros(3,1);
               vJ(1)=qJ(sc,vp(1));vJ(2)=qJ(sc,vp(2));vJ(3)=qJ(sc,vp(3));
               if (abs(min(vJ)-max(vJ))<1e3*eps)
                   vg=zeros(3,1);
                   vg(1)=qg(sc,vp(1));vg(2)=qg(sc,vp(2));vg(3)=qg(sc,vp(3));
                    [~,ind]=min(vg);pcand(j)=vp(ind);
               else
                  [~,ind]=min(vJ);pcand(j)=vp(ind);
               end
               Jcand(j)=qJ(sc,pcand(j));
            end
            [~,ind]=min(Jcand);
            pcand=pcand(ind);
            [Jcand,gcand]=BBS(pcand,param);
        end
        if (gcurrent<=0) 
            Cond=(((Jcand<Jcurrent)&&(gcand<=0))||...
                ((Jcand<=Jcurrent)&&(gcand<0)));
        else
            Cond=(gcand<gcurrent);
        end
    end
    if (Cond)
        sc.p=pcand;sc.alpha=sc.beta_plus*sc.alpha;
        Jcurrent=Jcand;gcurrent=gcand;
    else
        sc.p=sc.p;sc.alpha=max(sc.alpha_min,sc.beta_moins*sc.alpha);
    end
end

return