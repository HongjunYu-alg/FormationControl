function [is,tm,robot]=exc(t,robot)
tm=min(robot.sys);
is=1;
ctlst={[-4,-2,-1,-0.5,-0.1,0,0.1,0.5,1,2,4],...
    [-120,-90,-45,-10,-1,0,1,10,45,90,120]*pi/180};
row=[1:5,7:11];
col=[1:5,7:11];
if t>=tm
    is=0;
    for w=find(robot.sys==tm)
        % [wh,robot.ds(w),cp,dtn]=point2pth(pth,pt,dir);
        % [~,~,cp,dtn]=point2pth(pth,pt,dir);
        % ww=[];
        % for k=[1:w-1,w+1:size(robot.loc,1)]
        %     if norm(robot.loc(w,:)-robot.loc(k,:))<5
        %         ww(end+1)=k;
        %     end
        % end
        % if ~isempty(ww)
        %     robot.ms{w}=[];
        %     for ks=1:length(ctlst{1})
        %         for kr=1:length(ctlst{2})
        %             robot.stat(w,1:2)=[ctlst{1}(ks),ctlst{2}(kr)];
        %             robot.ms{w}(1:length(ww),ks,kr)=getmds(robot,w,ww);
        %             robot.ms{w}(1:length(ww),ks,kr)=getctm(robot,w,ww);
        %         end
        %     end
        % end
        [~,cp,dtn]=pt2pth(robot.pth{w},robot.loc(w,:),robot.ip(w));
        clear d;
        if w~=robot.ld
            for ks=1:length(ctlst{1})
                for kr=1:length(ctlst{2})
                    locc=moverb(robot.loc(w,:),ctlst{1}(ks),...
                        robot.stat(w,3:4),ctlst{2}(kr),0.1);
                    d(ks,kr)=norm(0.5*cp+0.5*dtn-locc);

                    [~,ccp,~]=pt2pth(robot.pth{w},locc,robot.ip(w));
                    [~,pt1,~]=pt2pth(robot.pth{w},robot.loc(robot.ld,:),robot.ltf(w));
                    [~,pt2,~]=pt2pth(robot.pth{w},locc,robot.ip(w));
                    d(ks,kr)=d(ks,kr)+(abs(dsbypth(pt1,robot.ltf(w),pt2,robot.ip(w),robot.pth{w})...
                        -robot.fmt(w))*0.8+0.2*norm(ccp-locc))*0.1;
                end
            end
            [v,one]=min(d(row,col));
            [~,two]=min(v);
            one=one(two);
            robot.stat(w,1:2)=[ctlst{1}(row(one)),ctlst{2}(col(two))];
        elseif w==robot.ld
            for ks=1:length(ctlst{1})
                for kr=1:length(ctlst{2})
                    locc=moverb(robot.loc(w,:),ctlst{1}(ks),...
                        robot.stat(w,3:4),ctlst{2}(kr),0.1);
                    d(ks,kr)=norm(0.5*cp+0.5*dtn-locc)+sum(robot.er);
                end
            end
            [v,one]=min(d(row,col));
            [~,two]=min(v);
            one=one(two);
            robot.stat(w,1:2)=[ctlst{1}(row(one)),ctlst{2}(col(two))];
        else
            robot.stat(w,1:2)=0;
        end
        robot.sys(w)=robot.sys(w)+0.1;
    end
else
    tm=t;
end