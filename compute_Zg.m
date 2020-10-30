function sc=compute_Zg(sc_past)
coder.allowpcode('plain');
    sc=sc_past;
    if (sc.qgmin*sc.qgmax>0),
        sc.ngz=0;
    else
        sDelta=sqrt(sc.bg^2-4*sc.ag*sc.cg);
        if (abs(sc.ag)<eps),
            p1=-sc.cg/sc.bg;p2=-sign(sc.bg)*inf;
        else
            p1=(-sc.bg-sDelta)/(2*sc.ag);
            p2=(-sc.bg+sDelta)/(2*sc.ag);
        end
        p_minus=sc.pc+sc.beta*min([p1;p2]);
        p_plus=sc.pc+sc.beta*max([p1;p2]);
        sc.Z=zeros(4,1);
        cond1=(p_minus<=sc.pbarmin)&&(sc.gpbarmin<=0);
        if (cond1),
            sc.ngz=1;
            sc.Z(1:2)=[sc.pbarmin;p_plus];
        else
            cond2=(p_minus<=sc.pbarmin)&&(sc.gpbarmax<=0);
            if (cond2),
                sc.ngz=1;
                sc.Z(1:2)=[p_plus;sc.pbarmax];
            else
               cond3=(p_plus>=sc.pbarmax)&&(sc.gpbarmin<=0);
               if (cond3),
                   sc.ngz=1;
                   sc.Z(1:2)=[sc.pbarmin;p_minus];
               else
                   cond4=(p_plus>=sc.pbarmax)&&(sc.gpbarmax<=0);
                   if (cond4),
                       sc.ngz=1;
                       sc.Z(1:2)=[p_minus;sc.pbarmax];
                   else
                       cond5=(p_minus<=sc.pbarmax)&&(p_minus>=sc.pbarmin)...
                           &&(p_plus<=sc.pbarmax)&&(p_plus>=sc.pbarmin)&&...
                           (sc.ag>=0);
                       if cond5,
                           sc.ngz=1;
                           sc.Z(1:2)=[p_minus;p_plus];
                       else
                           sc.ngz=2;
                           sc.Z=[sc.pbarmin;p_minus;p_plus;sc.pbarmax];
                       end
                   end
               end
            end
        end
    end
return