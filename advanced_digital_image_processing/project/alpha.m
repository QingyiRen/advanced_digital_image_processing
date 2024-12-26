function y = alpha(pic,m,tau1,tau2)

im = pic;
S_2 = zeros (size(im));
values = zeros(size(im));
for ky = 1:m
    for kx = 1:m
        for  y = -(m/2-1):m/2 
            for  x = -(m/2-1):m/2
               values(y+m/2,x+m/2)=im(y+m/2-1,x+m/2-1)*exp(((-2i)*pi)*((kx*x/m)+(ky*y/m)));
            end
        end       
        S_2(ky,kx) = sum(sum(values));
        u=ky-2/m;
        v=kx-2/m;
        f(ky,kx) = sqrt((2*u/m)^2+(2*v/m)^2);%im(y+m/2,x+m/2)*exp(((-2i)*pi)*((kx*x/m)+(ky*y/m)));
        theta(ky,kx) =atan2(v,u);
        values(:,:) = 0;        
    end
end

% finding unique values in matrix f
uni=unique(f);
zx=zeros(1,length(uni));
for ky = 1:m
    for kx = 1:m
        for i=1:length(uni)
            if uni(i)==f(ky,kx)
                zx(i)=zx(i)+f(ky,kx);
            end
        end
    end
end


line=polyfit(log(uni),log(zx),1);
alphax=-line(1);
alphax
y=1-1/(1+exp(tau1*(alphax-tau2)));
end