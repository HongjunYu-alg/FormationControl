function [w,trg]=updateW(pth,w,trg,pt,hd)
if trg&&w<size(pth,1)&&hd*(pth(w,3:4)-pt)'<0
    w=w+1;
    trg=0;
elseif ~trg&&hd*(pth(w,3:4)-pt)'>=0
    trg=1;
end