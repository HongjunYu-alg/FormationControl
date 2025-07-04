function [wh,d2pth,ptp,dnt]=point2pth(pth,pt,dir)
ds(size(pth,1))=0;
cp(size(pth,1),2)=0;
id(size(pth,1))=0;pth
for k=1:size(pth,1)
    [ds(k),cp(k,1:2),id(k),ppt(k,1:2)]=point2line(pt,pth(k,:));
end
d2pth=min(ds);
wh=find(ds==d2pth,1,'last');
wh=wh+(id(wh)==2);
wh=wh*(wh<=size(pth,1))+size(pth,1)*(wh>size(pth,1));
ptp=cp(wh,1:2);
if wh==1||wh==size(pth,1)
    ptp=ppt(wh,1:2);
end
d2pth=d2pth*sign(dir*[0 1;-1 0]*(ptp-pt)');
if wh~=size(pth,1)
    dnt=pth(wh+1,3:4);
else
    dnt=pth(wh,3:4);
end