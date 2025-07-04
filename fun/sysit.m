function sysit(n)
load(['data/',num2str(n),' robots/robot.mat'],'robot');
robot.sys=rand(1,size(robot.loc,1))/10;
%%
fig=figure('position',[200,150,800,800],'color','white');
ax=axes('parent',fig,'unit','pixel','position',[25 25 750 750]);
hold(ax,'on');
box(ax,'on');
robot.fig=fig;
robot.ax=ax;
for k=1:size(robot.env,1)
    plot(robot.ax,robot.env(k,[1,3]),robot.env(k,[2,4]),'blue');
end
for k=1:size(robot.pth,1)
    plot(robot.ax,robot.pth(k,[1,3]),robot.pth(k,[2,4]),'black-.');
    text(mean(robot.pth(k,[1,3])),mean(robot.pth(k,[2,4])),num2str(k));
end
for k=1:size(robot.pth,1)
    robot.pth(k,5:6)=(robot.pth(k,3:4)-robot.pth(k,1:2))/norm(robot.pth(k,3:4)-robot.pth(k,1:2));
end
%%
pth=robot.pth;
robot.pth={};
q1=pth(1,1:2);
q2=pth(1,3:4);
for k=1:size(robot.loc,1)
    %%
    p=robot.loc(k,:);
    dp1_q1q2=abs((q2-q1)/norm(q2-q1)*[0 1;-1 0]*(q1-p)');
    cp=p+sign((q1-q2)*[0 1;-1 0]*(q1-p)')*(q1-q2)/norm(q1-q2)*[0 1;-1 0]*dp1_q1q2;
    ds=dp1_q1q2;
    %%
    si=sign((p-cp)*(pth(1,5:6)*[0 1;-1 0])');
    robot.pth{k}=alterpth(pth,ds*si);
end
for k=1:size(robot.loc,1)
    for kk=1:size(robot.pth{k},1)
        robot.pth{k}(kk,7)=norm(robot.pth{k}(kk,1:2)-robot.pth{k}(kk,3:4));
    end
end
for k=1:size(robot.loc,1)
    sft=norm(robot.pth{k}(1,1:2)-robot.loc(k,:))...
        *sign((robot.loc(k,:)-robot.pth{k}(1,1:2))*robot.pth{k}(1,5:6)');
    robot.pth{k}(1,[1:2,7])=[robot.loc(k,:),robot.pth{k}(1,7)-sft];
    robot.pth{k}(end,[3:4,7])=[robot.pth{k}(end,3:4)+sft*robot.pth{k}(end,5:6),robot.pth{k}(end,7)+sft];
end
%%
save(['data/',num2str(n),' robots/robot.mat'],'robot');