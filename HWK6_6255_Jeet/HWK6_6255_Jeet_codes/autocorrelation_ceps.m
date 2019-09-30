function ceps = autocorrelation_ceps(xf, L, p)
 win=hamming(L);
    xf=xf.*win;
    for k1=0:p
        R(k1+1)=sum(xf(1:L-k1).*xf(k1+1:L));
    end
    E=zeros(1,p);
    k=zeros(1,p);
    alpha=zeros(p,p);
    E(1)=R(1);
    check=1;
    k(check)=R(check+1)/E(check);
    alpha(check,check)=k(check);
    E(check+1)=(1-k(check).^2)*E(check);
    for check=2:p
        k(check)=(R(check+1)-sum(alpha(1:check-1,check-1)'.*R(check:-1:2)))/E(check);
        alpha(check,check)=k(check);
        for check1=1:check-1
            alpha(check1,check)=alpha(check1,check-1)-k(check)*alpha(check-check1,check-1);
        end
        E(check+1)=(1-k(check).^2)*E(check);
    end
    G=sqrt(E(p+1));

h(1) = alpha(p,1);

for i = 2:1:p
    sumvar = 0;
    for l = 2:1:i-1
        term = (l/i)*h(l)*alpha(p,i-l);
        sumvar = sumvar+term;
    end
    h(i) = alpha(p,i) + sumvar;
end
ceps = h;
end