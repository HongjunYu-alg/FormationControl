function [colm,opini]=getcolm(one,ww,pt,hd,ctrl,shp,opini,env)
colm=[];
for k=ww
    [colm(end+1),opini{2}(one,k,1),opini{2}(one,k,2)]=...
        coltm(shp{one},pt(one,:),ctrl(one,1),ctrl(one,2),hd(one,:),...
        shp{k},pt(k,:),ctrl(k,1),ctrl(k,2),hd(k,:),...
        opini{2}(one,k,1),opini{2}(one,k,2),1);
end
% colm
mds=inf;
% ei=[1 1 -1 -1 1 -1 1 -1 1 1 1 1 1 -1 1 1 -1 -1 1 -1 -1 1 1 1 1 -1 -1 1 1 1 -1 -1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1];
for k=1:size(env,1)
    tset=[env(k,1:2);env(k,3:4);env(k,1:2)/2+env(k,3:4)/2-(env(k,3:4)-env(k,1:2))/12*[0 1;-1 0]];
    tcolm=coltm(shp{one},pt(one,:),ctrl(one,1),ctrl(one,2),hd(one,:),tset,mean(tset,1),0,0,[0,1],0,0,0);
    mds=min([mds,tcolm]);
    % if one==1
    %     mds
    %     h=fill(tset([1:end,1],1),tset([1:end,1],2),'r');
    %     h1=fill(shp{one}([1:end,1],1),shp{one}([1:end,1],2),'b');
    %     input('');
    %     delete(h);
    %     delete(h1);
    % end
end
% mds
colm(end+1)=mds;