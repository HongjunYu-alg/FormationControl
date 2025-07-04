function [mds,n1,n2]=solvbf(set1,set2)
set1(end+1,:)=set1(1,:);
set2(end+1,:)=set2(1,:);
mds=inf;
for k1=1:size(set1,1)-1
    for k2=1:size(set2,1)-1
        ds=line2line(set1(k1,:),set1(k1+1,:),set2(k2,:),set2(k2+1,:));
        if ds<mds
            mds=ds;
            n1=k1;
            n2=k2;
        end
    end
end