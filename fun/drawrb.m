function hds=drawrb(robot,hds)
for k=1:size(hds,2)
    delete(hds{k});
end
x=[robot.loc(:,1);robot.env(:,1)];
y=[robot.loc(:,2);robot.env(:,2)];
xylm=[min(x),max(x),min(y),max(y)];
r=max([(xylm(2)-xylm(1)),(xylm(4)-xylm(3))])/2;
for k=1:size(robot.shp,2)
    tfmx=[robot.stat(k,3:4)*[0 1;-1 0];robot.stat(k,3:4)];
    sets=ones(size(robot.shp{k},1),1)*robot.loc(k,:)+robot.shp{k}*tfmx;
    hds{end+1}=fill(sets([1:end,1],1),sets([1:end,1],2),'b',...
        'facecolor',[0.3 0.3 1],'edgecolor',[0.2 0.2 0.5],...
        'facealpha',0.2,'edgealpha',0.6);
    set(hds{end},'parent',robot.ax);
    hds{end+1}=text(robot.loc(k,1)-robot.stat(k,3),robot.loc(k,2)-robot.stat(k,4),...
        num2str(k),'color','b',...
        'HorizontalAlignment','center','fontsize',18,'VerticalAlignment','middle','fontname','times');
    set(hds{end},'parent',robot.ax);
    si=2*(robot.stat(k,1)>=0)-1;
    tfmx=[si*robot.stat(k,3:4)*[0 1;-1 0];si*robot.stat(k,3:4)];
    tmp=ones(7,1)*robot.loc(k,:)...
        +r/12*[[0.05 0.05 0.15 0 -0.15 -0.05 -0.05]/10;0 [0.75 0.75 1 0.75 0.75]*0.6 0]'*tfmx;
    hds{end+1}=fill(tmp(:,1),tmp(:,2),'black');
    set(hds{end},'parent',robot.ax);
end
title(robot.ax,['Time is ',num2str(robot.t),' seconds'],'fontname','times','fontsize',18,'HorizontalAlignment','center');
xlim(robot.ax,mean(xylm([1,2]))+r*[-1,1]+5*[-1,1]);
ylim(robot.ax,mean(xylm([3,4]))+r*[-1,1]+5*[-1,1]);
pause(0.1);