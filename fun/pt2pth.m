function [d2pth,ptp,dnt]=pt2pth(pth,pt,ip)
% if ip<size(pth,1)&&dir*(pth(ip,3:4)-pt)'<0
%     ip=ip+1;
% end
[d2pth,ptp,~,ppt]=point2line(pt,pth(ip,:));
dnt=pth(ip,3:4);
if ip==1||ip==size(pth,1)
    ptp=ppt;
end