function [mds,n1,n2,foots]=solvit(set1,set2,n1,n2)
nex{1,1}=[2:size(set1,1),1];
nex{1,2}=[size(set1,1),1:size(set1,1)-1];
nex{2,1}=[2:size(set2,1),1];
nex{2,2}=[size(set2,1),1:size(set2,1)-1];
mds=inf;
while 1
    [ds(1),foots1]=line2line(set1(n1,:),set1(nex{1,1}(n1),:),set2(n2,:),set2(nex{2,1}(n2),:));
    [ds(2),foots2]=line2line(set1(n1,:),set1(nex{1,2}(n1),:),set2(n2,:),set2(nex{2,1}(n2),:));
    [ds(3),foots3]=line2line(set1(n1,:),set1(nex{1,1}(n1),:),set2(n2,:),set2(nex{2,2}(n2),:));
    [ds(4),foots4]=line2line(set1(n1,:),set1(nex{1,2}(n1),:),set2(n2,:),set2(nex{2,2}(n2),:));
    
    [ds,w]=min(ds);
    if ds<mds
        mds=ds;
        switch w
            case 1
                n1=nex{1,1}(n1);
                n2=nex{2,1}(n2);
                foots=foots1;
            case 2
                n1=nex{1,2}(n1);
                n2=nex{2,1}(n2);
                foots=foots2;
            case 3
                n1=nex{1,1}(n1);
                n2=nex{2,2}(n2);
                foots=foots3;
            case 4
                n1=nex{1,2}(n1);
                n2=nex{2,2}(n2);
                foots=foots4;
        end
    else
        break;
    end
end