function ctm=getctm(robot,k,lst)
if isempty(lst)
    lst=1:size(robot.loc,1);
end
ctm=[];
for kk=lst
    if k~=kk
        ctm(end+1)=coltm(robot.shp{k},robot.loc(k,:),robot.stat(k,2),robot.stat(k,3),robot.stat(k,3:4),...
            robot.shp{kk},robot.loc(kk,:),robot.stat(kk,2),robot.stat(kk,3),robot.stat(kk,3:4));
    else
        ctm(end+1)=inf;
    end
end