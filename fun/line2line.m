function [dis,foots]=line2line(p1,p2,q1,q2)
d(1,5)=0;
d(1,:)=[norm(p1-q1),p1,q1];
d(2,:)=[norm(p1-q2),p1,q2];
d(3,:)=[norm(p2-q1),p2,q1];
d(4,:)=[norm(p2-q2),p2,q2];
dp1_q1q2=abs((q2-q1)/norm(q2-q1)*[0 1;-1 0]*(q1-p1)');
f_p1_q1q2=p1+sign((q1-q2)*[0 1;-1 0]*(q1-p1)')*(q1-q2)/norm(q1-q2)*[0 1;-1 0]*dp1_q1q2;

dp2_q1q2=abs((q2-q1)/norm(q2-q1)*[0 1;-1 0]*(q1-p2)');
f_p2_q1q2=p2+sign((q1-q2)*[0 1;-1 0]*(q1-p2)')*(q1-q2)/norm(q1-q2)*[0 1;-1 0]*dp2_q1q2;

dq1_p1p2=abs((p2-p1)/norm(p2-p1)*[0 1;-1 0]*(p1-q1)');
f_q1_p1p2=q1+sign((p1-p2)*[0 1;-1 0]*(p1-q1)')*(p1-p2)/norm(p1-p2)*[0 1;-1 0]*dq1_p1p2;

dq2_p1p2=abs((p2-p1)/norm(p2-p1)*[0 1;-1 0]*(p1-q2)');
f_q2_p1p2=q2+sign((p1-p2)*[0 1;-1 0]*(p1-q2)')*(p1-p2)/norm(p1-p2)*[0 1;-1 0]*dq2_p1p2;

d(5,:)=[dp1_q1q2/((f_p1_q1q2-q1)*(f_p1_q1q2-q2)'<=0),p1,f_p1_q1q2];
d(6,:)=[dp2_q1q2/((f_p2_q1q2-q1)*(f_p2_q1q2-q2)'<=0),p2,f_p2_q1q2];
d(7,:)=[dq1_p1p2/((f_q1_p1p2-p1)*(f_q1_p1p2-p2)'<=0),f_q1_p1p2,q1];
d(8,:)=[dq2_p1p2/((f_q2_p1p2-p1)*(f_q2_p1p2-p2)'<=0),f_q2_p1p2,q2];

cp=lineXline([p1,p2],[q1,q2]);
if (cp-p1)*(cp-p2)'<=0&&(cp-q1)*(cp-q2)'<=0
     d(9,:)=[0,cp,cp];
     % h=plot(cp(1),cp(2),'ro');
     % tmp=[p1;p2];
     % h1=plot(tmp(:,1),tmp(:,2),'r');
     % tmp=[q1;q2];
     % h2=plot(tmp(:,1),tmp(:,2),'r');
     % input('');
     % delete(h);
     % delete(h1);
     % delete(h2);
end
[dis,wh]=min(d(:,1));

foots=[d(wh,2:3);d(wh,4:5)];