%---------------------------------------------------------
% Author : Mazen Alamir 
% CNRS, UNiversity of Grenoble-Alpes
% Gipsa Lab. Last modification March 2017
%---------------------------------------------------------

%--------------------------------------------------------------------------
% This function compute the parametrization matrix R used in the
% expression p=R*p_r where p is the original piece-wise control profile
% while p_r is the vector of reduced parametrization.
%--------------------------------------------------------------------------
function R=compute_R(Ifree,Np,nu)
coder.allowpcode('plain');    
    Ifree(1)=1;
    nr=length(Ifree);
    R=zeros(Np*nu,nr*nu);
    for i=1:Np,
       if (i==1),
           R(1:nu,1:nu)=eye(nu);
       elseif (i>=Ifree(nr)),
           R((i-1)*nu+1:i*nu,(nr-1)*nu+1:nr*nu)=eye(nu);
       else
           ji=find(Ifree<=i, 1, 'last' );
           R((i-1)*nu+1:i*nu,nu*(ji-1)+1:nu*ji)=...
               (1-(i-Ifree(ji))/(Ifree(ji+1)-Ifree(ji)))*eye(nu);
           R((i-1)*nu+1:i*nu,nu*ji+1:nu*(ji+1))=...
               (i-Ifree(ji))/(Ifree(ji+1)-Ifree(ji))*eye(nu);
       end
    end
return
%--------------------------------------------------------------------------