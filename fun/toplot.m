function hds=toplot(loc,hd,env,shp,ax,t,ctrl,hds)
for k=1:size(hds,2)
    delete(hds{k});% loc,hd,env,shp,ax,t,ctrl
end
x=[loc(:,1);env(:,1)];
y=[loc(:,2);env(:,2)];
xylm=[min(x),max(x),min(y),max(y)];
r=max([(xylm(2)-xylm(1)),(xylm(4)-xylm(3))])/2;
for k=1:size(shp,2)
    tfmx=[hd(k,:)*[0 1;-1 0];hd(k,:)];
    sets=ones(size(shp{k},1),1)*loc(k,:)+shp{k}*tfmx;
    hds{end+1}=fill(sets([1:end,1],1),sets([1:end,1],2),'b',...
        'facecolor',[0.3 0.3 1],'edgecolor',[0.2 0.2 0.5],...
        'facealpha',0.2,'edgealpha',0.6);
    set(hds{end},'parent',ax);
    hds{end+1}=text(loc(k,1)-hd(k,1),loc(k,2)-hd(k,2),...
        num2str(k),'color','b',...
        'HorizontalAlignment','center','fontsize',16,'VerticalAlignment','middle','fontname','times');
    set(hds{end},'parent',ax);
    si=2*(ctrl(k,1)>=0)-1;
    tfmx=[si*hd(k,:)*[0 1;-1 0];si*hd(k,:)];
    tmp=ones(7,1)*loc(k,:)...
        +r/12*[[0.05 0.05 0.15 0 -0.15 -0.05 -0.05]/10;0 [0.75 0.75 1 0.75 0.75]*0.6 0]'*tfmx;
    hds{end+1}=fill(tmp(:,1),tmp(:,2),'black');
    set(hds{end},'parent',ax);
end
% title(ax,['Time is ',num2str(t),' seconds'],'fontname','times','fontsize',18,'HorizontalAlignment','center');
xlim(ax,mean(xylm([1,2]))+r*[-1,1]+5*[-1,1]);
ylim(ax,mean(xylm([3,4]))+r*[-1,1]+5*[-1,1]);