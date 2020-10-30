function [tc,yc]=compacty(t,y,np)
coder.allowpcode('plain');
tc=reshape(linspace(t(1),t(end),np),np,1);
yc=zeros(np,size(y,2));
for j=1:size(y,2),
    yc(:,j)=interp1(t,y(:,j),tc);
end
end

