% Progrmming assignment for AP3132-Advanced Digital Image Processing course
% Instructor: B. Rieger, F. Vos 
% Tutor: H. Heydarian
% Term: Q3-2021
%
% Labwork #3
%
clear
close all
addpath('D:\dipimage_3.2_windows_fftw\diplib\share\DIPimage');
setenv('PATH',['D:\dipimage_3.2_windows_fftw\diplib\bin',';',getenv('PATH')]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem #1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Harris corner detection

% generate a right-angles triangle with angles alpha and 90-alpha
alpha = pi/10;
I = triangle_local(alpha);
dipshow(I)
%%
% parameter settings
sigma_grad = 1;
sigma_tensor = 3;%note this must be larger than sigma_grad
k = 0.06;
thresh = 10;

% compute the cornerness R with proper parameters
[xy, R] = harris(I, sigma_grad, sigma_tensor, k, thresh);
dipshow(R,'lin')
colormap('jet')

%%
% compute cornerness for trui.tif and water.tif
% TODO2
sigma_grad = 1;
sigma_tensor = 2;%note this must be larger than sigma_grad
J = readim('water.tif');
[xy, J1] = harris(J, sigma_grad, sigma_tensor, k, thresh);
dipshow(J1,'lin')


sigma_grad = 1;
sigma_tensor = 2;%note this must be larger than sigma_grad
J = readim('trui.tif');
[xy, J2] = harris(J, sigma_grad, sigma_tensor, k, thresh);
dipshow(J2,'lin')

pause

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem #2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PCA

clear all
close all
clc

% read the input images (6 different channels)
I = readim(['multispecData.ics']);
% this is a 3D image where the 6 different channels are stored in the thrid
% dimension
h=dipshow(I);
h.Name='6 input channels';
h.NumberTitle='off';
% use the tab 'Action' step through slices to see each channel or use the
% keyboard shortcuts 'n' (next) and 'p' (previous) 

% get dimensions
In = im2mat(I); % convert to Maltab 3D array for processing
[M, N, channel] = size(In);

% reshape the six images to a matrix X of size (height*width)x6
% i.e. each image become a vector of size height*width 
% TODO 3
In_res=[];
for i=1:channel
    In_res=[In_res In(:,:,i)];
end
% compute the mean (mx) and covariance (Cx) of X
% TODO 4
mx=mean(In_res,2);
Cx=cov(In_res');
% compute the eigenvalues and eigenvectors of Cx.
% check the eigenvalues of Cx with the table in the manual
% TODO 5
[V,D]=eig(Cx);
% construct the matrix U whose rows are 
% formed from the eigenvectors U1 of Cx arranged in descending value of their
% eigenvalues
scatter(real(eig(Cx)),imag(eig(Cx)))
% compute the principle components (Hotelling transform)
components = 100;
for i=1:size(V,2)
    U(:,size(V,2)-i+1)=V(:,i);
end
y=U*(In_res-mx*ones(1,size(In_res,2)));
% plot the principle components
dipshow(y,'lin')
% reconstruction using the main k components
% U=zeros(size(Cx));
% U(:,1:components)=V(:,(size(Cx,2)-components+1):size(Cx,2));
U(:,(components+1):size(U,2))=zeros(size(U,1),size(U,2)-components);
x=U'*y+mx*ones(1,size(In_res,2));
% x=U'*y+mx*ones(1,size(In_res,2));
% TODO 6
dipshow(x,'lin')
% form the matrix Uk from the k eigenvectors corresponding to the k
% largest eigenvalues
% TODO 7

% reconstruction using the k components
% projection of 6 channels onto 2 eigenvectors
% TODO 8

% convert xp vectors to MxN images Inew
% compute the difference image
% compute the mean squared error between x and xp using the formula in the

% PCA method
components = 100;               
[coeff,score,latent] = pca(In_res);
score_k=zeros(size(score));
score_k(:,1:components)=score(:,1:components);
In_construct = score_k*coeff';
dipshow(In_construct,'lin');
% lecture notes