function y =  luminance(pic,b,k,gamma)
y=(b*ones(size(pic))+k.*pic).^gamma;
end