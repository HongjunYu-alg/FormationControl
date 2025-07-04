function [ds,robot]=getmdsbf(robot,k)
for kk=1:size(robot.loc,1)
    if kk~=k
        hea1=robot.stat(k,3:4);
        hea2=robot.stat(kk,3:4);
        shp1=robot.shp{k};
        shp2=robot.shp{kk};
        loc1=robot.loc(k,:);
        loc2=robot.loc(kk,:);
        tfmx1=[hea1*[0 1;-1 0];hea1];
        sets1=ones(size(shp1,1),1)*loc1+shp1*tfmx1;
        tfmx2=[hea2*[0 1;-1 0];hea2];
        sets2=ones(size(shp2,1),1)*loc2+shp2*tfmx2;
        [ds(kk),robot.sdi(k,kk),robot.sdi(kk,k)]=solvbf(sets1,sets2);
    else
        ds(kk)=inf;
    end
end