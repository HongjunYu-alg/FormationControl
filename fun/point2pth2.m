function [dest,h,dst]=point2pth2(pt,pth,L)
for k=1:size(pth,1)
    [v,~,~,pnts(k,1:2)]=point2line(pt,pth(k,:));
    eva(k)=v;
end
[h,w]=min(eva);
dest=pnts(w,1:2);
dst=dest;

wk=w;
while L>0
    lk=norm(pth(wk,3:4)-dest);
    if lk>=L
        dest=dest+L*(pth(wk,3:4)-dest)/lk;
        L=0;
    else
        dest=pth(wk,3:4);
        if wk<size(pth,1)
            L=L-lk;
            wk=wk+1;
        else
            L=0;
        end
    end
end