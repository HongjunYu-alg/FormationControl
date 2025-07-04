function [ds,mds,opini]=getsrds(w,ww,pt,hd,shp,opini,env)
hea1=hd(w,:);
loc1=pt(w,:);
shp1=shp{w};
tfmx1=[hea1*[0 1;-1 0];hea1];
sets1=ones(size(shp1,1),1)*loc1+shp1*tfmx1;
ds=[];
for k=ww
    hea2=hd(k,:);
    loc2=pt(k,:);
    shp2=shp{k};
    tfmx2=[hea2*[0 1;-1 0];hea2];
    sets2=ones(size(shp2,1),1)*loc2+shp2*tfmx2;
    if opini{1}(w,k,1)==0
        [ds(end+1),opini{1}(w,k,1),opini{1}(w,k,2)]=solvbf(sets1,sets2);
    else
        [ds(end+1),opini{1}(w,k,1),opini{1}(w,k,2)]=...
            solvit(sets1,sets2,opini{1}(w,k,1),opini{1}(w,k,2));
    end
end
mds=inf;
% ei=[1 1 -1 -1 1 -1 1 -1 1 1 1 1 1 -1 1 1 -1 -1 1 -1 -1 1 1 1 1 -1 -1 1 1 1 -1 -1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1];
for k=1:size(env,1)
    tset=[env(k,1:2);env(k,3:4);env(k,1:2)/2+env(k,3:4)/2-(env(k,3:4)-env(k,1:2))/12*[0 1;-1 0]];
    mds=min([mds,solvbf(sets1,tset)]);
end