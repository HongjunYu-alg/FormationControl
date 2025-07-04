function [tm,n1,n2]=coltm(shp1,loc1,spe1,omg1,hea1,...
    shp2,loc2,spe2,omg2,hea2,n1,n2,type)
tfmx1=[hea1*[0 1;-1 0];hea1];
sets1=ones(size(shp1,1),1)*loc1+shp1*tfmx1;
if type
    tfmx2=[hea2*[0 1;-1 0];hea2];
    sets2=ones(size(shp2,1),1)*loc2+shp2*tfmx2;
else
    tfmx2=[1 0;0 1];
    sets2=shp2;
end
% figure;hold on;
% plot(sets1([1:end,1],1),sets1([1:end,1],2),'b');
% plot(sets2([1:end,1],1),sets2([1:end,1],2),'b');
% axis([-14 106.3139 -37.2488 83.0651]);
if n1==0
    [ds,n1,n2]=solvbf(sets1,sets2);
else
    [ds,n1,n2]=solvit(sets1,sets2,n1,n2);
end
r1=0;
for k=1:size(shp1,1)
    r1=max([r1,norm(shp1(k,:))]);
end
r2=0;
for k=1:size(shp2,1)
    r2=max([r2,norm(shp2(k,:))]);
end
tm=0;
while ds>0.00001&&tm<5
    % nds
    if ~ds
        break;
    end
    dt=ds/(abs(r1*omg1)+abs(r2*omg2)+abs(spe1)+abs(spe2));
    [loc1,hea1]=moverb(loc1,spe1,hea1,omg1,dt);
    [loc2,hea2]=moverb(loc2,spe2,hea2,omg2,dt);
    tm=tm+dt;
    tfmx1=[hea1*[0 1;-1 0];hea1];
    sets1=ones(size(shp1,1),1)*loc1+shp1*tfmx1;
    if type
        tfmx2=[hea2*[0 1;-1 0];hea2];
        sets2=ones(size(shp2,1),1)*loc2+shp2*tfmx2;
    else
        tfmx2=[1 0;0 1];
        sets2=shp2;
    end
    [ds,n1,n2]=solvit(sets1,sets2,n1,n2);
end
% if tm==0
%     nn1
% end