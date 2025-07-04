function [loc,ppt]=cord2loc(pt,pth,w)
loc=0;
for k=1:w-1
    loc=loc+norm(pth(k,3:4)-pth(k,1:2));
end
[~,~,~,ppt]=point2line(pt,pth(w,:));
loc=loc+norm(ppt-pth(w,1:2))*sign((ppt-pth(w,1:2))*(pth(w,3:4)-pth(w,1:2))');