function er=fmer(pt,pth,tal)
for kn=tal
    clear LL eva pnts
    Ln=0;
    for k=1:size(pth{kn},1)
        Ln=Ln+norm(pth{kn}(k,1:2)-pth{kn}(k,3:4));
        [v,~,~,pnts(k,1:2)]=point2line(pt(kn,:),pth{kn}(k,:));
        eva(k)=v;
        if k==1
            LL(k)=0;
        else
            LL(k)=LL(k-1)+norm(pth{kn}(k-1,1:2)-pth{kn}(k-1,3:4));
        end
    end
    [~,w]=min(eva);
    er(kn)=(LL(w)+norm(pnts(w,1:2)-pth{kn}(w,1:2)))/Ln;
end