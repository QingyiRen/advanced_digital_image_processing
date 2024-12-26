% harris corner detector

function [xy, R] = harris(img, sigma_grad, sigma_tensor, k, thresh)

    % TODO1
    % compute image derivatives
    imgDx =dx(img,sigma_grad);
    imgDy =dy(img,sigma_grad);
    
    imgDxx =dx(imgDx,sigma_grad);
    imgDyy =dy(imgDy,sigma_grad);
    imgDxy= dy(imgDx,sigma_grad);
    imgDxx_bar=gaussf(imgDxx,sigma_tensor);
    imgDyy_bar=gaussf(imgDyy,sigma_tensor);
    imgDxy_bar=gaussf(imgDxy,sigma_tensor);
    % construct the structure tensor by computing its elements
    S_bar = [imgDxx_bar imgDxy_bar;imgDxy_bar imgDyy_bar];
    % compute the cornerness according to Harris measure
    R=det(S_bar)-k*trace(S_bar)^2;
    
    
    % find the location of pixels with cornerness above thresh
    xy = findcoord(R>thresh);
    
end