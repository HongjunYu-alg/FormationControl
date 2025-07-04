function pair=smpcontr(hea,loc,dest)
s1=2*(hea*(dest-loc)'>=0)-1;
s2=2*(hea*[0 1;-1 0]*(dest-loc)'>=0)-1;
hea=real(hea/norm(hea));
cs=abs(hea*(dest-loc)'/norm((dest-loc)));
pair=real([4*cs*s1,s2*s1*2.5*acos(cs)]);