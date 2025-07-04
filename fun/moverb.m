function [loc,hea]=moverb(loc,spe,hea,omg,dt)
if omg~=0&&spe~=0
    theta=omg*dt;
    Et=[cos(theta),sin(theta);-sin(theta),cos(theta)];
    vec1=spe/omg*hea*[0,1;-1,0];
    hea=hea*Et/norm(hea);
    vec2=spe/omg*hea*[0,1;-1,0];
    loc=loc-vec2+vec1;
elseif omg==0&&spe~=0
    loc=loc+spe*hea*dt;
elseif omg~=0&&spe==0
    theta=omg*dt;
    Et=[cos(theta),sin(theta);-sin(theta),cos(theta)];
    hea=hea*Et/norm(hea);
end