function y = block(pic,m,d)
[x1,x2]=size(pic);
p=(x1-d)/(m-d);
q=(x2-d)/(m-d);
% y = zeros(p,q,m,m);
% y = cell(p,q);
for i=1:p
    for j=1:q
        y(i,j)=pic((i-1)*(m-d)+1:i*(m-d)+d,(j-1)*(m-d)+1:j*(m-d)+d);
    end
end
end