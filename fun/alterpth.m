function pth=alterpth(pth,ds)
for k=1:size(pth,1)
    pth(k,1:6)=[pth(k,1:2)+pth(k,5:6)*[0,1;-1,0]*ds,...
        pth(k,3:4)+pth(k,5:6)*[0,1;-1,0]*ds,pth(k,5:6)];
end
for k=2:size(pth,1)
    pt=lineXline(pth(k-1,1:4),pth(k,1:4));
    pth(k-1,3:4)=pt;
    pth(k,1:2)=pt;
end
k0=1;
while 1
    flag=1;
    for k=k0:size(pth,1)
        if (pth(k,3:4)-pth(k,1:2))*pth(k,5:6)'<0
            pth(k,:)=[];
            flag=0;
            pt=lineXline(pth(k-1,1:4),pth(k,1:4));
            pth(k-1,3:4)=pt;
            pth(k,1:2)=pt;
            break;
        end
    end
    if flag
        break;
    end
end