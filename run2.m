function run2(tal)
clear global;
close all;
addpath('fun');
allfigs;
return;
load('data/10 robots/rb.mat','rb','pt','hd','env','shp','ax','fig');

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
%%
% tal=4;
oths={[2,3,9,10],[3,5,10],[3,5,10,9],[1,6,7,8],[],...
    [1,2,7,8],[1,2,3],[1,2,9],[3,5,10],[5]};
%%
set(fig,'position',[1,70,700,700]);
set(ax,'position',[25,25,650,650]);
% for k=tal
%     plot([rb.pth{k}(:,1);rb.pth{k}(end,3)],[rb.pth{k}(:,2);rb.pth{k}(end,4)])
% end
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
plot(envt([1:end,1],3),envt([1:end,1],4),'black');
% for k=1:size(env,1)
%     text(env(k,1),env(k,2),num2str(k));
% end
%%
for k=1:size(pt,1)
    ttl(k)=0;
    for kk=1:size(rb.pth{k},1)
        ttl(k)=ttl(k)+norm(rb.pth{k}(kk,1:2)-rb.pth{k}(kk,3:4));
    end
    opini{1}(k,size(pt,1),2)=0;
    opini{2}(k,size(pt,1),2)=0;
end
hds={};
ctrl=zeros(10,2);
pt=pt+0.1*randn(size(pt))+kron([1 -2],ones(size(pt,1),1));
actt=[rand(1,size(pt,1))/20;ones(1,size(pt,1))];
t=0;
odt=t;
dest={};
er=fmer(pt,rb.pth,tal);
folderPath = 'pcs';
if exist(folderPath, 'dir')
    if ~rmdir(folderPath, 's')
        disp('failed');
    end
end
mkdir(folderPath);
rec{1}={t,pt,hd,ctrl,actt};
psn=zeros(2,size(pt,1));
for k=1:size(pt,1)
    ptw(k,1:2)=rb.pth{k}(end,3:4);
end
derr=fmer2(ptw,rb.pth,tal,1);
derr=derr-mean(derr);
while min(er(tal))<0.995
    er=fmer(pt,rb.pth,tal);
    %% update new control
    wh=tal(actt(1,tal)==min(actt(1,tal)));
    dtau=actt(1,wh(1))-t;
    t=actt(1,wh(1));
    for k=wh
        [ctrl,opini,actt,dest{k},psn]=control(k,pt,hd,rb,shp,ctrl,opini,...
            actt,env,oths,tal,er,rb.pth,psn,envt,derr);
    end
    for k=tal
        [pt(k,:),hd(k,1:2)]=moverb(pt(k,:),ctrl(k,1),hd(k,1:2),ctrl(k,2),dtau);
    end
    %% update plot
    if t>odt+0.1
        odt=t;
        hds=toplot(pt,hd,env,shp,ax,t,ctrl,hds);
        xlabel(num2str(er(tal)));
        for k=1:size(dest,2)
            if ~isempty(dest{k})
                hds{end+1}=plot(dest{k}(:,1),dest{k}(:,2),'r*');
                % hds{end+1}=text(dest{k}(1,1),dest{k}(1,2),num2str(k));
            end
        end
        % figname=[folderPath,'/fig-',...
        %     num2str(length(dir([folderPath,'/fig-*.*']))+1),'.png'];
        % f=getframe(gcf);
        % imwrite(f.cdata,figname);
        pause(0.01);
    end
    rec{end+1}={t,pt,hd,ctrl,actt};
end
save('rec.mat','rec');

function [ctrl,opini,actt,dest,psn]=control(one,pt,hd,rb,shp,ctrl,opini,actt,...
    env,oths,tal,er,pth,psn,envt,derr)
err=fmer2(pt,pth,tal,1);
err(err<0)=10^-6;
err=err-mean(err);
% er(er<0)=10^-6;
dv=derr(one==tal)-err(one==tal);
dv=dv*(abs(dv)<2)+2*sign(dv)*(abs(dv)>=2);
lib={[0,[-1 1]*(1+dv/8)],...
    [-120,-50,-5,5,50,120]*pi/180};
%%
oth=tal((err>err(tal==one))&(err<err(tal==one)+10));
ptw=pt;
hdw=hd;
ctrlw=ctrl;
% if one==1
%     disp('_________________________');
% end
colm=min(getcolm(one,oth,ptw,hdw,ctrlw,shp,opini,env));
if colm==0
    save('bugs1.mat','one','oth','ptw','hdw','ctrlw','shp','opini','env');
    input('fail coll time');
end
[srds,mds,opini]=getsrds(one,oth,ptw,hdw,shp,opini,env);
if ismember(0,[srds,mds])
    save('bugs2.mat','one','oth','ptw','hdw','ctrlw','shp','opini','env');
    input('collide distance');
end
if actt(2,one)==1
    ww=oth(srds<0.3);
    wwe=mds<0.3;
    actt(2,one)=2;
elseif actt(2,one)==2
    ww=oth(srds<0.6);
    wwe=mds<0.6;
end
%%
ww=oth(srds<2);
wwe=mds<2;
if ~isempty(ww)||wwe
    crn.colm=[];
    crn.srds=[];
    sts.srds=zeros(0,2);
    for k=1:length(lib{1})
        for kk=1:length(lib{2})
            ptw=pt;
            hdw=hd;
            ctrlw=ctrl;
            ctrlw(one,:)=[lib{1}(k),lib{2}(kk)];
            crn.colm(end+1)=min(getcolm(one,oth,ptw,hdw,ctrlw,shp,opini,env));
            [ptw(one,:),hdw(one,1:2)]=moverb(ptw(one,:),ctrlw(one,1),hdw(one,:),ctrlw(one,2),0.1);
            for kw=oth
                [ptw(kw,:),hdw(kw,1:2)]=moverb(ptw(kw,:),ctrlw(kw,1),hdw(kw,:),ctrlw(kw,2),0.1);
            end
            [tsrds,tmds,~]=getsrds(one,ww(ww>0),ptw,hdw,shp,opini,env);
            crn.srds(end+1)=min([tsrds,tmds]);
            sts.srds(end+1,:)=[lib{1}(k),lib{2}(kk)];
        end
    end
else
    actt(2,one)=1;
end
%%
% envt=getCFpth(env,pt(one,:));
[ddest,~,dst]=point2pth2(pt(one,:),rb.pth{one},3.5);
clear eva
for k=1:size(env,1)
    [v,~,~,pnts(k,1:2)]=point2line(ddest,env(k,:));
    eva(k)=v;
end
if min(eva)>4
    dest=ddest;
else
    clear eva pnts
    for k=1:size(envt,1)
        [v,~,~,pnts(k,1:2)]=point2line(pt(one,:),envt(k,:));
        eva(k)=v;
    end
    [~,w]=min(eva);
    dest=pnts(w,1:2);

    wk=w;
    L=3.5;
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
end
%%
crn.d2t=[];
sts.d2t=zeros(0,2);
for k=1:length(lib{1})
    for kk=1:length(lib{2})
        ptw=pt(one,:);
        hdw=hd(one,:);
        [ptw,~]=moverb(ptw,lib{1}(k),hdw,lib{2}(kk),0.1);
        crn.d2t(end+1)=norm(dest(1,:)-ptw);
        sts.d2t(end+1,:)=[lib{1}(k),lib{2}(kk)];
    end
end
%% distance-to-target(d2t) collision-time(colm) shortest-distance(srds)
if actt(2,one)==1
    [~,wone]=min(crn.d2t);
elseif actt(2,one)==2
    if min(crn.srds)>0.3&&min(crn.colm)<=0.5
        [~,wone]=max(crn.colm);
    elseif min(crn.srds)<=0.3
        [~,wone]=max(crn.srds);
    elseif min(crn.srds)>0.3&&min(crn.colm)>0.5
        [~,wone]=min(crn.d2t);
    end
end
ctrl(one,:)=sts.d2t(wone,:);
colm=min(getcolm(one,oth,pt,hd,ctrl,shp,opini,env));
actt(1,one)=actt(1,one)+median([0.1,colm/4,0.01]);

