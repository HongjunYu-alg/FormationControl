function [ds,cp,wh,ppt]=point2line(p,q)
q1=q(1:2);
q2=q(3:4);
d(1,3)=0;
dp1_q1q2=abs((q2-q1)/norm(q2-q1)*[0 1;-1 0]*(q1-p)');
f_p1_q1q2=p+sign((q1-q2)*[0 1;-1 0]*(q1-p)')*(q1-q2)/norm(q1-q2)*[0 1;-1 0]*dp1_q1q2;
d(1,:)=[norm(p-q1),q1];
d(2,:)=[norm(p-q2),q2];
si=((f_p1_q1q2-q1)*(f_p1_q1q2-q2)'<=0);
d(3,:)=[dp1_q1q2/si,f_p1_q1q2];
if ~si
    d(3,1)=inf;
end
[ds,wh]=min(d(:,1));
cp=d(wh,2:3);
ppt=f_p1_q1q2;