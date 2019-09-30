function [phim,phiv,EC,alphac,GC]=covariance(x_frame,L,p)
    for check=1:p
        for k=1:p
            phim(check,k)=sum(x_frame(p+1-check:p+L-check).*x_frame(p+1-k:p+L-k));
        end
    end
    
    for check=1:p
        phiv(check)=sum(x_frame(p+1-check:p+L-check).*x_frame(p+1:p+L));
        phiz(check)=sum(x_frame(p+1:p+L).*x_frame(p+1-check:p+L-check));
    end
    phi0=sum(x_frame(p+1:p+L).^2);
    phiv=phiv';
    alphac=inv(phim)*phiv;
    EC=phi0-sum(alphac'.*phiz);
    GC=sqrt(EC);
end
