function robot=updaterb(t,robot)
dt=t-robot.t;
if dt>0
    for k=1:size(robot.shp,2)
        [robot.loc(k,:),robot.stat(k,3:4)]=moverb(robot.loc(k,:),robot.stat(k,1),...
            robot.stat(k,3:4),robot.stat(k,2),dt);
        if k~=robot.ld
            clear d
            for kk=1:size(robot.pth{k},1)
                d(kk)=point2line(robot.loc(robot.ld,:),robot.pth{k}(kk,:));
            end
            [~,robot.ltf(k)]=min(d);
        end
        if robot.tg(k)&&robot.ip(k)<size(robot.pth{k},1)&&...
                robot.stat(k,3:4)*(robot.pth{k}(robot.ip(k),3:4)-robot.loc(k,1:2))'<0
            robot.ip(k)=robot.ip(k)+1;
            robot.tg(k)=0;
        elseif ~robot.tg(k)&&robot.stat(k,3:4)*(robot.pth{k}(robot.ip(k),3:4)-robot.loc(k,1:2))'>=0
            robot.tg(k)=1;
        end
    end
    robot.t=t;
end