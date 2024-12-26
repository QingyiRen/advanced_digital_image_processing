clear;
close all;
addpath('D:\dipimage_3.2_windows_fftw\diplib\share\DIPimage');
setenv('PATH',['D:\dipimage_3.2_windows_fftw\diplib\bin',';',getenv('PATH')]);

b=0.7656;
k=0.0364;
gamma=2.2;
T1=5;
T2=2;
tau1=-3;
tau2=2;
%% S1: Spectral Measure of Sharpness

% Read the input image
im_color = readim('Tiger.jpg'); % the input image clearly shows jpg compression artifacts in the back (false colors)

%Convert colored picture to grayscale via a pixel-wise transformation
im = 0.2989*im_color{1}+0.5870*im_color{2}+0.1140*im_color{2};
im1=im(1:2036,1:1524);
% dipshow(im)
m=20;
d=4;
[x1,x2]=size(im1);
p=(x1-d)/(m-d);
q=(x2-d)/(m-d);
% Contrast selection
for i=1:p
    for j=1:q
%         j*(m-d)+d
        pic=im(((i-1)*(m-d)+1):(i*(m-d)+d),((j-1)*(m-d)+1):(j*(m-d)+d));
        pic=luminance(pic,b,k,gamma);
        contrast(i,j)=contr(pic,T1,T2);
    end
end

% y = block(im,m,d);
% y = cell(p,q);
for i=1:p
    for j=1:q
        if contrast(i,j)==0
         alp(i,j)=0;
        else
         alp(i,j)=alpha(im((i-1)*(m-d)+1:i*(m-d)+d,(j-1)*(m-d)+1:j*(m-d)+d),m,tau1,tau2);
        end
    end
end







%% s2: Spatial Measure of Sharpness



