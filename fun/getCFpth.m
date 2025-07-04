function envt=getCFpth(env,pt)
envt=env;
for k=1:size(env,1)
    envt(k,5:6)=(env(k,3:4)-env(k,1:2))/norm(env(k,3:4)-env(k,1:2));
    eva(k)=point2line(pt,env(k,1:4));
end
meva=min(eva);
envt=alterpth(envt([1:end,1],:),3.5);
envt(1,1:2)=envt(end,1:2);
envt(end,:)=[];