function ds=dsbypth(pt1,wh1,pt2,wh2,pth)
ds=0;
for k=[wh1+1:wh2-1,wh2+1:wh1-1]
    ds=ds+pth(k,7);
end
if wh1<wh2
    ds=ds+norm(pth(wh1,3:4)-pt1)+norm(pth(wh2,1:2)-pt2);
elseif wh1>wh2
    ds=-(ds+norm(pth(wh2,3:4)-pt2)+norm(pth(wh1,1:2)-pt1));
else
    ds=norm(pt1-pt2)*sign((pt2-pt1)*pth(wh1,5:6)');
end