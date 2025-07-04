function generaterobots(n)
ne=3+randi(4,1,n);
for k=1:n
    ang=0.2+rand(ne(k),1);
    ang=ang/sum(ang)*2*pi;
    ang=sort(ang);
    matrix=zeros(ne(k),ne(k));
    matrix(tril(true(ne(k)), 0)) = 1;
    ang=matrix*ang;
    rx=rand*0.6+0.8;
    ry=rand*1.6+1.4;
    delta=rand*2*pi;
    robot.shp{k}=[cos(ang)*rx,sin(ang)*ry]...
        *[cos(delta),sin(delta);-sin(delta),cos(delta)];
    ang=2*pi*rand;
    vec=[cos(ang),sin(ang)];
    robot.stat(k,1:4)=[0,0,vec];
end
robot.loc=[0,0];
w=1;
while w<n
    nloc=robot.loc(randi(w),:)+8*(rand(1,2)-0.5);
    set2=ones(size(robot.shp{w+1},1),1)*nloc+robot.shp{w+1};
    mds=inf+zeros(1,size(robot.loc,1));
    for k=1:size(robot.loc,1)
        set1=ones(size(robot.shp{k},1),1)*robot.loc(k,:)+robot.shp{k};
        ds=solvbf(set1,set2);
        mds(k)=min([mds(k),ds]);
    end
    if min(mds)>2
        robot.loc(end+1,:)=nloc;
    end
    w=size(robot.loc,1);
end
if exist(['data/',num2str(n),' robots'],'dir')
    rmdir(['data/',num2str(n),' robots'],'s');
end
mkdir(['data/',num2str(n),' robots']);
if exist(['data/',num2str(n),' robots/pics'],'dir')
    rmdir(['data/',num2str(n),' robots/pics'],'s');
end
mkdir(['data/',num2str(n),' robots/pics']);
load('env.mat','env');
robot.env=env;
save(['data/',num2str(n),' robots/robot.mat'],'robot');
sysit(n);