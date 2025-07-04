function allfigs
close all;
% load('rec.mat','ctrl','t');
% plot(t,ctrl{1}(:,1));return;
fig11;

function fig15
load('rec.mat','env','envt','pth');
figure('position',[50,50,720,656],'color','white');
ax=axes('position',[0.11,0.11,0.85,0.85],'fontsize',20,'fontname','times');
xlabel('X');
ylabel('Y');
box on;
grid on;
hold on;
fill(env([1:end,1],3),env([1:end,1],4),'black','facealpha',0.1,'edgecolor','none');
fill(envt([1:end,1],3),envt([1:end,1],4),'red','facealpha',0.1,'edgecolor','none');
for k=1:10
    pt=pth{k}(1,1:2);
    while 1
        pt=point2pth2(pt,pth{k},0.1);
        clear eva
        for ke=1:size(env,1)
            v=point2line(pt,env(ke,:));
            eva(ke)=v;
        end
        if min(eva)>=4
            break;
        end
    end
    while norm(pt(end,:)-pth{k}(end,3:4))>0.15
        ddest=point2pth2(pt(end,:),pth{k},0.1);
        clear eva
        for ke=1:size(env,1)
            v=point2line(ddest,env(ke,:));
            eva(ke)=v;
        end
        if min(eva)>4
            pt(end+1,:)=ddest;
        else
            clear eva pnts
            for ke=1:size(envt,1)
                [v,~,~,pnts(ke,1:2)]=point2line(pt(end,:),envt(ke,:));
                eva(ke)=v;
            end
            [~,w]=min(eva);
            dest=pnts(w,1:2);

            wk=w;
            L=0.1;
            if wk>=27&&wk<=70
                while L>0
                    lk=norm(envt(wk,1:2)-dest);
                    if lk>=L
                        dest=dest+L*(envt(wk,1:2)-dest)/norm(envt(wk,1:2)-dest);
                        break;
                    else
                        dest=envt(wk,1:2);
                        L=L-lk;
                        if wk>1
                            wk=wk-1;
                        else
                            wk=size(envt,1);
                        end
                    end
                end
            else
                while L>0
                    lk=norm(envt(wk,3:4)-dest);
                    if lk>=L
                        dest=dest+L*envt(wk,5:6);
                        L=0;
                    else
                        dest=envt(wk,3:4);
                        L=L-lk;
                        if wk<size(envt,1)
                            wk=wk+1;
                        else
                            wk=1;
                        end
                    end
                end
            end

            pt(end+1,:)=dest;
        end
    end
    plot([pth{k}(1,1);pth{k}(:,3)],[pth{k}(1,2);pth{k}(:,4)],'g-.');
    plot(pt(:,1),pt(:,2),'b','linewidth',1.1);
end
xlim(46+[-1,1]*56);
ylim(23+[-1,1]*51);
print(gcf,'paths-paths','-depsc');

function fig14
load('rec.mat','ctrl','t')
figure('position',[50,50,1000,400],'color','white', 'Visible', 'on');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[5,1],[5,2],[4,1],[4,2],[3,1],[3,2],[2,1],[2,2],[1,1],[1,2]};
off=300;
for kn=1:10
    if kn==1
        % ax=axes('position',[0.08+0.5*(cood{kn}(2)-1),0.06+0.195*(cood{kn}(1)-1),0.42,0.145],'fontsize',18,'fontname','times');
        ax=axes('position',[0.08 0.12 0.88 0.84],'fontsize',18,'fontname','times');
        xlabel(ax,'Time (second)');
        ylabel(ax,'Speed (meter/second)');
        box(ax,'on');
        grid(ax,'on');
        hold(ax,'on');
    end
    clear tt av
    for k=off+1:length(t)-off-1
        av(k-off)=(t(k-off+1:k+off+1)-t(k-off:k+off))*abs(ctrl{kn}(k-off:k+off,1))/sum(t(k+off+1)-t(k-off));
        tt(k-off)=t(k);
    end
    plot(tt,av,'b',...
        'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
        'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    legend('NumColumns',4,'location','northeast');
    ylim(ax,[0.5,1.5]);
    xlim(ax,[t(1),t(end)]);
end
print(gcf,'forward-speed','-depsc');

function fig13
load('rec.mat','ctrl','t')
figure('position',[50,50,1000,400],'color','white', 'Visible', 'on');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[5,1],[5,2],[4,1],[4,2],[3,1],[3,2],[2,1],[2,2],[1,1],[1,2]};
off=600;
for kn=1:10
    if kn==1
        % ax=axes('position',[0.08+0.5*(cood{kn}(2)-1),0.06+0.195*(cood{kn}(1)-1),0.42,0.145],'fontsize',18,'fontname','times');
        ax=axes('position',[0.08 0.12 0.88 0.84],'fontsize',18,'fontname','times');
        xlabel(ax,'Time (second)');
        ylabel(ax,'Speed (rad/second)');
        box(ax,'on');
        grid(ax,'on');
        hold(ax,'on');
    end
    for k=off+1:length(t)-off
        av(k-off)=sum(ctrl{kn}(k+(-off:off),2))/(t(k+off)-t(k-off));
        tt(k-off)=t(k);
    end
    plot(tt,av,'b',...
        'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
        'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    legend('NumColumns',4,'location','southeast');
    % ylim(ax,[0,0.13]);
    xlim(ax,[t(1),t(end)]);
end
print(gcf,'rotation-speed','-depsc');

function fig12
load('rec.mat','actt','t');
figure('position',[50,50,1000,1000],'color','white', 'Visible', 'off');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[5,1],[5,2],[4,1],[4,2],[3,1],[3,2],[2,1],[2,2],[1,1],[1,2]};
for kn=1:10
    av=actt{2}(:,kn);
    tt=t(1);
    va=av(1);
    for kt=2:length(t)
        if av(kt)~=va(end)
            va(end+1)=av(kt);
            tt(end+1)=t(kt);
        end
    end
    va(end+1)=av(end);
    tt(end+1)=t(end);
    ax=axes('position',[0.08+0.48*(cood{kn}(2)-1),0.16+0.18*(cood{kn}(1)-1),0.42,0.09],'fontsize',18,'fontname','times');
    xlabel(ax,'Time (second)');
    box(ax,'on');
    grid(ax,'on');
    hold(ax,'on');
    plot(ax,[tt(1),kron(tt(2:end-1),[1,1]),tt(end)],kron(va(1:end-1),[1,1]),'b',...
        'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
        'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    set(gca,'ytick',[1,2],'yticklabel',{'Safe','Danger'});
    ylim([0 3.5]);
    xlim(ax,[t(1),t(end)]);
    legend();
end
print(gcf,'OperationModes','-depsc');

function fig11
load('rec.mat','t','pt','pth');
figure('position',[50,50,1000,400],'color','white', 'Visible', 'on');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[1,1],[1,2],[2,1],[2,2],[3,1],[3,2],[4,1],[4,2],[5,1],[5,2]};
for kn=1:3%:10
    clear dev
    for kt=1:length(t)
        clear eva
        for kk=1:size(pth{kn},1)
            eva(kk)=sign((pt{kn}(kt,:)-pth{kn}(kk,1:2))*[0 1;-1 0]...
                *(pth{kn}(kk,3:4)-pth{kn}(kk,1:2))')...
                *point2line(pt{kn}(kt,:),pth{kn}(kk,:));
        end
        [~,w]=min(abs(eva));
        dev(kt)=eva(w);
    end
    if kn==1
        % ax=axes('position',[0.08+0.5*(cood{kn}(2)-1),0.06+0.195*(cood{kn}(1)-1),0.42,0.145],'fontsize',18,'fontname','times');
        ax=axes('position',[0.08 0.12 0.88 0.84],'fontsize',18,'fontname','times');
        xlabel(ax,'Time (second)');
        ylabel(ax,'Distance (meter)');
        box(ax,'on');
        grid(ax,'on');
        hold(ax,'on');
    end
    % set(ax,'ytick',[0 0.01 0.05 0.1 0.13]);
    plot(t,...
        dev,'b',...
        'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
        'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    legend('NumColumns',5,'location','northeast');
    % ylim(ax,[0,0.13]);
    xlim(ax,[t(1),t(end)]);
end
print(gcf,'Distance2path','-depsc');

function fig10
load('rec.mat','delay');
figure('position',[50,50,1000,1200],'color','white', 'Visible', 'off');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[1,1],[1,2],[2,1],[2,2],[3,1],[3,2],[4,1],[4,2],[5,1],[5,2]};
for kn=1:10
    t=delay{kn}(:,1)';
    va=delay{kn}(:,2)';
    tt=delay{kn}(1,1);
    tm=0;
    for k=2:length(t)
        if va(k)~=va(k-1)
            tm(end+1)=va(k);
            tt(end+1)=t(k);
        else
        end
    end
    tt(end+1)=t(k);
    tm(end+1)=tm(end);
    ax=axes('position',[0.08+0.5*(cood{kn}(2)-1),0.06+0.195*(cood{kn}(1)-1),0.42,0.145],'fontsize',18,'fontname','times');
    xlabel(ax,'Time (second)');
    ylabel(ax,'Duration (seconds)');
    box(ax,'on');
    grid(ax,'on');
    hold(ax,'on');
    set(ax,'ytick',[0 0.01 0.05 0.1 0.13]);
    plot(t,...
        va,'b',...
        'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
        'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    legend();
    ylim(ax,[0,0.13]);
    xlim(ax,[t(1),t(end)]);
end
legend('NumColumns',3,'location','northeast');
print(gcf,'robot-delay','-depsc');

function fig9
load('rec.mat','rec','pth','colm','t');
tal=1:10;
for k=1:10
    delay{k}=zeros(0,2);
end
for kt=1:size(rec,2)
    pt=rec{kt}{2};
    actt=rec{kt}{5};
    wh=tal(actt(1,tal)==min(actt(1,tal)));
    for one=wh
        err=fmer2(pt,pth,tal,1);
        err(err<0)=10^-6;
        err=err-mean(err);
        oth=tal((err>err(tal==one))&(err<err(tal==one)+10));
        dly=[];
        for k=oth
            if one<k&&~isempty(colm{one,k})
                dly(end+1)=colm{one,k}(kt);
            elseif k<one&&~isempty(colm{k,one})
                dly(end+1)=colm{k,one}(kt);
            end
        end
        delay{one}(end+1,:)=[t(kt),median([0.1,min(dly)/4,0.01])];
    end
end
save('rec.mat','delay','-append');
hold on;
for k=1:10
    plot(delay{k}(:,1),delay{k}(:,2));
end

function fig8
load('rec.mat','actt','t');
figure('position',[50,50,1000,1200],'color','white', 'Visible', 'off');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[1,1],[1,2],[2,1],[2,2],[3,1],[3,2],[4,1],[4,2],[5,1],[5,2]};
for kn=1:10
    va=actt{1}(:,kn)';
    tt=t(1);
    tm=0;
    for k=2:length(t)
        if va(k)~=va(k-1)
            tm(end+1)=va(k);
            tt(end+1)=t(k);
        else
        end
    end
    tt(end+1)=t(k);
    tm(end+1)=tm(end);
    ax=axes('position',[0.08+0.5*(cood{kn}(2)-1),0.06+0.195*(cood{kn}(1)-1),0.42,0.145],'fontsize',18,'fontname','times');
    xlabel(ax,'Time (second)');
    ylabel(ax,'Duration (seconds)');
    box(ax,'on');
    grid(ax,'on');
    hold(ax,'on');
    plot(t,va);
    % plot([tt(1),kron(tt(2:end),[1,1]),tt(end)],...
    %     [kron(tm(1:end),[1,1])],'b',...
    %     'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
    %     'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    legend();
    % ylim(ax,[0,0.15]);
    xlim(ax,[t(1),t(end)]);
end
legend('NumColumns',3,'location','northeast');
print(gcf,'control-interval','-depsc');

function fig7
load('rec.mat','actt','t');
figure('position',[50,50,1000,1200],'color','white', 'Visible', 'off');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[1,1],[1,2],[2,1],[2,2],[3,1],[3,2],[4,1],[4,2],[5,1],[5,2]};
for kn=1:10
    va=actt{2}(:,kn)';
    tt=t(1);
    tm=0;
    for k=2:length(t)
        if va(k)~=va(k-1)
            tm(end+1)=0;
            tt(end+1)=t(k);
        else
            tm(end)=tm(end)+t(k)-t(k-1);
        end
    end
    tt(end+1)=t(k);
    tm(end+1)=tm(end);
    ax=axes('position',[0.08+0.5*(cood{kn}(2)-1),0.06+0.195*(cood{kn}(1)-1),0.42,0.145],'fontsize',18,'fontname','times');
    xlabel(ax,'Time (second)');
    ylabel(ax,'Duration (seconds)');
    box(ax,'on');
    grid(ax,'on');
    hold(ax,'on');
    plot([tt(1),kron(tt(2:end),[1,1]),tt(end)],...
        [kron(tm(1:end),[1,1])],'b',...
        'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
        'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    legend();
    ylim(ax,[0,300]);
    xlim(ax,[t(1),t(end)]);
end
legend('NumColumns',3,'location','northeast');
print(gcf,'control-modes','-depsc');

function fig2
load('rec.mat','ctrl','t');
figure('position',[50,50,1000,1200],'color','white', 'Visible', 'off');
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
cood={[1,1],[1,2],[2,1],[2,2],[3,1],[3,2],[4,1],[4,2],[5,1],[5,2]};
for kn=1:size(ctrl,2)
    clear tm num
    tm=t(1);
    num=0;
    si=sign(sign(ctrl{kn}(1,2))+0.5);
    for k=2:length(t)
        if si*ctrl{kn}(k,2)>0
            num(end)=num(end)+t(k)-t(k-1);
        elseif si*sign(sign(ctrl{kn}(k,2))+0.5)==0
        else
            num(end+1)=0;
            tm(end+1)=t(k);
            si=-si;
        end
    end
    ax=axes('position',[0.04+0.5*(cood{kn}(2)-1),0.06+0.195*(cood{kn}(1)-1),0.45,0.145],'fontsize',18,'fontname','times');
    xlabel(ax,'Time (second)');
    ylabel(ax,'Duration (seconds)');
    box(ax,'on');
    grid(ax,'on');
    hold(ax,'on');
    plot(ax,[tm(1),kron(tm(2:end-1),[1,1]),tm(end)],...
        [kron(tm(2:end)-tm(1:end-1),[1,1])],'b',...
        'DisplayName',['Robot ',num2str(kn)],'color',clr(kn,:),...
        'linewidth',1.1,'marker',mkr{kn},'linestyle',lnsty{kn});
    legend();
    % tv=[kron(tm(2:end)-tm(1:end-1),[1,1])];
    % mtv=get(ax,'ylim');
    % ylim([0,max([max(tv(290:end))*1.4,mtv(2)])]);
    ylim([0,6]);
    xlim(ax,[t(1),t(end)]);
end
legend('NumColumns',3,'location','northeast');
print(gcf,'rotation-holds','-depsc');

function fig6
load('rec.mat','colm','srds','t');
tmp=zeros(0,length(t));
for k=1:10
    for kk=[1:k-1,k+1:10]
        if k<kk
            if ~isempty(colm{k,kk})
                tmp(end+1,:)=colm{k,kk};
            end
        else
            if ~isempty(colm{kk,k})
                tmp(end+1,:)=colm{kk,k};
            end
        end
    end
end
a=min(tmp);
b=max(tmp);
figure('position',[50,50,1200,400],'color','white');
axes('position',[0.05,0.15,0.92,0.78],'fontsize',18,'fontname','times');
xlabel('Time (second)');
ylabel('Collision Time (meter/second)');
box on;
grid on;
hold on;
hold on;
xlim([t(1),t(end)]);
aa=a>=5;
while ~isempty(a)
    [~,q]=ismember(1,aa);
    if q>0
        plot(t(1:q-1),a(1:q-1),'black');
        t(1:q)=[];
        a(1:q)=[];
        aa(1:q)=[];
    else
        plot(t,a,'black');
        break;
    end
end
% plot(t,a,'black');
% fill(t([1:end,end:-1:1,1]),[a,b(end:-1:1),a(1)],'b','facealpha',0.2);
print(gcf,'collisiontime','-depsc');

function fig5
load('rec.mat','pth','env');
pt=pth{1}(1,1:2);
opt=pt;
va=[];
xta=[];
dsn=0;
while fmer(pt,pth,1)<0.999
    pt=point2pth2(pt,pth{1},0.1);
    dsn(end+1)=dsn(end)+0.1;
    xta(end+1)=180/pi*atan((pt(2)-opt(2))/(pt(1)-opt(1)));
    opt=pt;
    eva1=[];
    for k=14:30
        eva1(end+1)=point2line(pt,env(k,:));
    end
    eva2=[];
    for k=[30:33,1:14]
        eva2(end+1)=point2line(pt,env(k,:));
    end
    va(end+1)=(min(eva2)+min(eva1))/2;
end
figure('position',[50,50,1200,400],'color','white');
axes('position',[0.05,0.15,0.88,0.78],'fontsize',18,'fontname','times');
xlabel('Distance Along Path (meter)');
ylabel('Distance to Environment Contour (meter)');
box on;
grid on;
hold on;
hold on;
plot(dsn(2:end),va,'b-.','DisplayName','Distance');
xlim([0,dsn(end)]);
yyaxis right
plot(dsn(2:end),xta-mean(xta),'r','DisplayName','Angle');
ylabel('Angle of Direction (deg)');
legend('location','southeast');
print(gcf,'distance2env','-depsc');

function fig1
load('rec.mat','t','pt','env','envt','shp','rec');
figure('position',[50,50,720,656],'color','white');
ax=axes('position',[0.11,0.11,0.85,0.85],'fontsize',20,'fontname','times');
xlabel('X');
ylabel('Y');
box on;
grid on;
hold on;
for kn=1:size(pt,2)
    plot(pt{kn}(:,1),pt{kn}(:,2),'b-.');
end
sntm=[0,50,100,180,260,320,t(end)];
cood=[0 7;38 -20;12 32;57 -11;73 42;55 58;-5 47];
for k=1:length(sntm)
    [~,wt]=min(abs(t-sntm(k)));
    toplot(rec{wt}{2},rec{wt}{3},env,shp,ax,t(wt),rec{wt}{4},{});
    text(cood(k,1),cood(k,2),['Time is ',num2str(round(sntm(k),1))],...
        'fontname','Times','fontsize',20);
end
plot(env([1:end,1],3),env([1:end,1],4),'black');
plot(envt([1:end,1],3),envt([1:end,1],4),'red');
xlim(46+[-1,1]*56);
ylim(23+[-1,1]*51);
print(gcf,'paths','-depsc');
get(gca,'xlim')
get(gca,'ylim')
get(gcf,'position')

function fig4
figure('position',[50,50,1200,400],'color','white');
axes('position',[0.08,0.15,0.88,0.78],'fontsize',18,'fontname','times');
xlabel('Time (second)');
ylabel('Formation Error (meter)');
box on;
grid on;
hold on;
load('rec.mat','er','t','pth');
L=0;
for k=1:size(pth{1},1)
    L=L+norm(pth{1}(k,3:4)-pth{1}(k,1:2));
end
er=er*L;
er=er-mean(er,2)*ones(1,10);
clr=[1 0 0;1 0 0;0 0 1;0 0 1;0 0 0;0 0 0;0.6 0.6 0.1;0.6 0.6 0.1;0.1 0.6 0.6;0.1 0.6 0.6];
lnsty={'-','-.','-','-.','-','-.','-','-.','-','-.'};
mkr={'none','none','none','none','none','none','none','none','none','none'};
for kn=1:10
    plot([t(1)-0.01,t(kron(2:length(t),[1 1])-1),t(end)],kron(er(:,kn)',[1 1]),...
        'black','color',clr(kn,:),'linestyle',lnsty{kn},'DisplayName',['Rob ',num2str(kn)],...
        'linewidth',1.02,'marker',mkr{kn});
    pause(0.01);
end
legend('NumColumns',4);
xlim([0 t(end)]);
print(gcf,'formation-error','-depsc');

function fig3
load('rec.mat','ctrl','t');
figure('position',[50,50,1200,400],'color','white');
ax=axes('position',[0.08,0.15,0.88,0.78],'fontsize',18,'fontname','times');
xlabel('Rotational Speed (rad/second)');
ylabel('Time (second)');
box on;
grid on;
hold on;
clr=[0.6 0 0;0 0.6 0;0 0 0.6;0.6 0.6 0;0.6 0 0.6;0 0.6 0.6;0.2 0.4 0.2;0.4 0.2 0.2;0.2 0.2 0.4;0 0 0];
lnsty={'-','--','-.','-','--','--','-.','-','-.','--'};
mkr={'none','none','none','+','+','o','none','s','none','s'};
for kn=1:size(ctrl,2)
    out=sort(unique(ctrl{kn}(:,1)));
    ut=out(out>0)';
    clear num
    for k=1:length(ut)
        num(k)=0;
        [~,q]=ismember(ut(k),ctrl{kn}(:,1));
        for wn=q
            if wn<length(t)
                num(k)=t(wn+1)-t(wn);
            end
        end
    end
    clear ct sp
    dsp=0.06;
    sp=(min(ut)-2*dsp):dsp:(max(ut)+2*dsp);
    % sp=0.8-2*dsp:dsp:1.2+2*dsp;
    % sp=sort(-sp,'ascend');
    for k=1:length(sp)
        wh=(ut>=sp(k)).*(ut<sp(k)+dsp);
        ct(k)=0;
        [~,q]=ismember(1,wh);
        if q(1)
            ct(k)=ct(k)+sum(num(q));
        end
    end
    if ~isempty(sp)
        plot([sp(1)-dsp,sp(kron(2:length(sp),[1 1])-1),sp(end)],kron(ct,[1 1]),...
            'black','color',clr(kn,:),'linestyle',lnsty{kn},'DisplayName',['Rob ',num2str(kn)],...
            'linewidth',1.1,'marker',mkr{kn});
        [v,w]=max(ct);
        text(sp(w)-0.5*dsp,v+0.0015,['Rob ',num2str(kn)],'fontsize',18,...
            'fontname','times','HorizontalAlignment','center');
    end
    pause(0.01);
end
ylim([0,0.04]);
legend('NumColumns',3);
print(gcf,'speed','-depsc');

function add2rec2
load('data/10 robots/rb.mat','rb');
load('rec.mat','rec');
pth=rb.pth;
for kt=1:size(rec,2)
    pt=rec{kt}{2};
    er(kt,1:10)=fmer(pt,pth,1:10);
end
save('rec.mat','er','pth','-append');

function add2rec
load('rec.mat','rec','shp','env');
for k=1:10
    opini{1}(k,10,2)=0;
    opini{2}(k,10,2)=0;
end
for k=1:9
    for kk=k+1:10
        colm{k,kk}=[];
        srds{k,kk}=[];
    end
    colm{k,11}=[];
    srds{k,11}=[];
end
colm{10,11}=[];
srds{10,11}=[];
for kt=1:size(rec,2)
    pt=rec{kt}{2};
    hd=rec{kt}{3};
    ctrl=rec{kt}{4};
    for k=1:10
        sets{k}=ones(size(shp{k},1),1)*pt(k,:)+shp{k}*[hd(k,:)*[0 1;-1 0];hd(k,:)];
    end
    for kk=1:size(env,1)
        tset{kk}=[env(kk,1:2);env(kk,3:4);env(kk,1:2)/2+env(kk,3:4)/2-(env(kk,3:4)-env(kk,1:2))/12*[0 1;-1 0]];
    end
    for k=1:10
        if k<9
            for kk=k+1:10
                colm{k,kk}(kt)=coltm(shp{k},pt(k,:),ctrl(k,1),ctrl(k,2),hd(k,:),...
                    shp{kk},pt(kk,:),ctrl(kk,1),ctrl(kk,2),hd(kk,:),...
                    opini{2}(k,kk,1),opini{2}(k,kk,2),1);
                srds{k,kk}(kt)=solvbf(sets{k},sets{kk});
            end
        end
        mds=inf;
        tmds=inf;
        for kk=1:size(env,1)
            mds=min([mds,coltm(shp{k},pt(k,:),ctrl(k,1),ctrl(k,2),hd(k,:),tset{kk},mean(tset{kk},1),0,0,[0,1],0,0,0)]);
            tmds=min([tmds,solvbf(sets{k},tset{kk})]);
        end
        colm{k,11}(kt)=mds;
        srds{k,11}(kt)=tmds;
    end
end
for k=1:size(rec,2)
    actt{1}(k,1:10)=rec{k}{5}(1,:);
    actt{2}(k,1:10)=rec{k}{5}(2,:);
end
save('rec.mat','actt','colm','srds','-append');

function prep
load('data/10 robots/rb.mat','env','shp');
load('rec.mat','rec');
ei=[1 1 -1 -1 1 -1 1 -1 1 1 1 1 1 -1 1 1 -1 -1 1 -1 -1 1 1 1 1 -1 -1 1 1 1 -1 -1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1];
for k=1:size(env,1)
    if ei(k)>0
        env(k,:)=env(k,[3:4,1:2]);
    end
end
env([15,18],1)=env([15,18],1)-2;
env([11,15],3)=env([11,15],3)-2;

for k=2:size(env,1)
    va=[env(k-1,3)-env(k:end,1),env(k-1,4)-env(k:end,2)];
    [~,wk]=min(sum(abs(va),2));
    env([k,k-1+wk],:)=env([k-1+wk,k],:);
end
envt=env;
for k=1:size(env,1)
    envt(k,5:6)=(env(k,3:4)-env(k,1:2))/norm(env(k,3:4)-env(k,1:2));
end
envt=alterpth(envt([1:end,1],:),4);
envt(1,1:2)=envt(end,1:2);
envt(end,:)=[];
envtt=envt([1:end,1],:);
envv=env([1:end,1],:);
for k=size(envtt,1):-1:2
    if (envtt(k,3:4)-envtt(k,1:2))*[0 1;-1 0]*(envtt(k-1,3:4)-envtt(k-1,1:2))'>0
        % plot(envtt(k,1),envtt(k,2),'black*');
        % plot(envv(k,1)+3.5*cos(0:pi/200:2*pi),envv(k,2)+3.5*sin(0:pi/200:2*pi),'black');
        [~,~,~,tpt1]=point2line(envv(k,1:2),envtt(k-1,1:4));
        [~,~,~,tpt2]=point2line(envv(k,1:2),envtt(k,1:4));
        xta=acos((tpt1-envv(k,1:2))*(tpt2-envv(k,1:2))'/norm(tpt2-envv(k,1:2))/norm(tpt1-envv(k,1:2)));
        tmp=zeros(0,2);
        for dxt=xta*(0:1/(1+ceil(xta/(20*pi/180))):1)
            tmp(end+1,:)=(tpt2-envv(k,1:2))*[cos(dxt),sin(dxt);-sin(dxt),cos(dxt)];
        end
        tmp(:,1)=tmp(:,1)+envv(k,1);
        tmp(:,2)=tmp(:,2)+envv(k,2);
        % plot(tmp(:,1),tmp(:,2),'blacko');
        tmp=[tmp(1:end-1,:),tmp(2:end,:)];
        for kn=1:size(tmp,1)
            tmp(kn,5:6)=(tmp(kn,3:4)-tmp(kn,1:2))/norm(tmp(kn,3:4)-tmp(kn,1:2));
        end
        tmp=tmp(end:-1:1,:);
        envtt=[envtt(1:k-2,:);...
            envtt(k-1,1:2),tmp(1,1:2),envtt(k-1,5:6);...
            tmp;...
            % tmp(end,1:2),envtt(k,3:4),envtt(k,5:6);...
            envtt(k+1:end,:)];
    end
end
envt=envtt;
envt(end,:)=[];
envt(:,3:4)=envt([2:end,1],1:2);
for k=1:size(envt,1)
    envt(k,5:6)=(envt(k,3:4)-envt(k,1:2))/norm(envt(k,3:4)-envt(k,1:2));
end
%%
t=[];
pt={};
hd={};
ctrl={};
for k=1:size(rec,2)
    t(end+1)=rec{k}{1};
    for kn=1:size(rec{k}{2},1)
        pt{kn}(k,1:2)=rec{k}{2}(kn,:);
        hd{kn}(k,1:2)=rec{k}{3}(kn,:);
        ctrl{kn}(k,1:2)=rec{k}{4}(kn,:);
    end
end
save('rec.mat','t','pt','hd','ctrl','env','envt','shp','-append');