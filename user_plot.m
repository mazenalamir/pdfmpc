nl=100;
[ttc,xxc]=compacty(tt,xx,nl);
[~,uuc]=compacty(tt,uu,nl);
[~,rrdc]=compacty(tt,rrd,nl);
[~,tt_execc]=compacty(tt,tt_exec,nl);

figure(1);clf;
h(1)=subplot(321);plot(ttc,rrdc,'b-.',ttc,xxc(:,1),'k-','linewidth',2);grid on;
title('$r$ and $r^d$','fontsize',40,'interpreter','latex');

h(2)=subplot(322);plot(ttc,ones(size(ttc))*[-param.ocp.theta_max param.ocp.theta_max]*180/pi,'r-.',...
    ttc,180/pi*xxc(:,3),'k-','linewidth',2);grid on;
title('$\theta$ and its bounds','fontsize',40,'interpreter','latex');

h(3)=subplot(323);plot(ttc,ones(size(ttc))*[-param.ocp.thetap_max param.ocp.thetap_max],'r-.',...
    ttc,180/pi*xxc(:,4)','k','linewidth',2);grid on;

title('$\dot\theta$ and its bounds','fontsize',40,'interpreter','latex');
xlabel('time (sec)','fontsize',40,'interpreter','latex');

h(4)=subplot(324);plot(ttc,ones(size(ttc))*[param.pmin(1) param.pmax(1)],'r-.','linewidth',2); hold on;
[tts,uucs]=stairs(ttc,uuc);grid on;
plot(tts,uucs,'k-','linewidth',2);
title('$u$ and its bounds','fontsize',40,'interpreter','latex');
xlabel('time (sec)','fontsize',40,'interpreter','latex');

for i=1:4,
    subplot(3,2,i);set(gca,'fontsize',34);
end
set(gcf,'color','white');

h(5)=subplot(313);plot(tt(2:end-1),1000*tt_exec(2:end-1),'k','linewidth',2);
title('CPU-time (ms)','fontsize',40,'interpreter','latex');
xlabel('time (sec)','fontsize',40,'interpreter','latex');
grid on;set(gca,'fontsize',34);

linkaxes(h,'x')