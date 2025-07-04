function fmt=inifmt(pth,loc,ld,ip,ltf)
fmt(size(loc,1))=0;
for k=[1:ld-1,ld+1:size(loc,1)]
    [~,pt1,~]=pt2pth(pth{k},loc(ld,:),ltf(k));
    [~,pt2,~]=pt2pth(pth{k},loc(k,:),ip(k));
    fmt(k)=dsbypth(pt1,ltf(k),pt2,ip(k),pth{k});
end