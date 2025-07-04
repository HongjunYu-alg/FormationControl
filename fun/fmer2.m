function er=fmer2(pt,pth,tal,one)
er=[];
for kn=tal
    clear LL eva pnts
    Ln=0;
    for k=1:size(pth{one},1)
        Ln=Ln+norm(pth{one}(k,1:2)-pth{one}(k,3:4));
        [v,~,~,pnts(k,1:2)]=point2line(pt(kn,:),pth{one}(k,:));
        eva(k)=v;
        if k==1
            LL(k)=0;
        else
            LL(k)=LL(k-1)+norm(pth{one}(k-1,1:2)-pth{one}(k-1,3:4));
        end
    end
    [~,w]=min(eva);
    er(end+1)=(LL(w)+norm(pnts(w,1:2)-pth{one}(w,1:2)));
end