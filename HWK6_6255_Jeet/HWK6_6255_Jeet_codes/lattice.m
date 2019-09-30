function [EL,alphal,GL,k]=lattice(x_frame,L,p)
    e(:,1)=x_frame;
    b(:,1)=x_frame;
    k(1)=sum(e(p+1:p+L,1).*b(p:p+L-1,1))/sqrt((sum(e(p+1:p+L,1).^2)...
        *sum(b(p:p+L-1,1).^2)));
    alphal(1,1)=k(1);
    btemp=[0 b(:,1)']';
    e(1:L+p,2)=e(1:L+p,1)-k(1)*btemp(1:L+p);
    b(1:L+p,2)=btemp(1:L+p)-k(1)*e(1:L+p,1);
    for check=2:p
        k(check)=sum(e(p+1:p+L,check).*b(p:p+L-1,check))/sqrt((sum(e(p+1:p+L,check).^2)...
            *sum(b(p:p+L-1,check).^2)));
        alphal(check,check)=k(check);
        for j=1:check-1
            alphal(j,check)=alphal(j,check-1)-k(check)*alphal(check-j,check-1);
        end
        btemp=[0 b(:,check)']';
        e(1:L+p,check+1)=e(1:L+p,check)-k(check)*btemp(1:L+p);
        b(1:L+p,check+1)=btemp(1:L+p)-k(check)*e(1:L+p,check);
    end
    EL=sum(x_frame(p+1:p+L).^2);
    for check=1:p
        EL=EL*(1-k(check).^2);
    end
    GL=sqrt(EL);
end