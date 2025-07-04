function [wh,pt]=movebypth(pth,wh,pt,ds)
while 1
    if ds>0
        Ln=norm(pth(wh,3:4)-pt);
        if Ln<ds
            if wh<size(pth,1)
                ds=ds-Ln;
                pt=pth(wh,3:4);
                wh=wh+1;
            else
                pt=pt+ds*pth(wh,5:6);
                break;
            end
        else
            pt=pt+ds*pth(wh,5:6);
            break;
        end
    else
        Ln=norm(pth(wh,1:2)-pt);
        if Ln<-ds
            if wh>1
                ds=ds+Ln;
                pt=pth(wh,1:2);
                wh=wh-1;
            else
                pt=pt+ds*pth(wh,5:6);
                break;
            end
        else
            pt=pt+ds*pth(wh,5:6);
            break;
        end
    end
end