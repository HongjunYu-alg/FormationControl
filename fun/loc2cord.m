function [pt,k]=loc2cord(loc,pth)
d=0;
k=1;
while k<=size(pth,1)
    l=norm(pth(k,3:4)-pth(k,1:2));
    if l+d<loc
        d=d+l;
        k=k+1;
    else
        rat=(loc-d)/l;
        pt=(1-rat)*pth(k,1:2)+rat*pth(k,3:4);
        break;
    end
end
if k>size(pth,1)
    pt=pth(end,3:4);
    k=k-1;
end