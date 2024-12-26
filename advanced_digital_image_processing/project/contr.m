function y = contr(pic,T1,T2)
ma=max(pic);
mi=min(pic);
miu=mean(pic);
if (ma-mi)<=T1||miu<=T2
    y=0;
else 
    y=1;
end
end