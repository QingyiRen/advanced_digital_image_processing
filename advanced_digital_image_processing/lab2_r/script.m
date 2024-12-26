% Programming assignment for AP3132-Advanced Digital Image Processing course
% Instructor: B. Rieger, F. Vos 
% Tutor: S. Haghparast
% Year:2023
%
% Labwork #2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem #1              Fourier transform interpretation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
im1 = readim('FFT_sample1.ics');
im2 = readim('FFT_sample2.ics');

dipshow(im1)
title('FT image 1')
dipshow(im2)
title('FT image 2')
%Think how to set the display range. The Fourier transformation of an image
%is complex. How to display the image??

% Solution: find the frequency as the peak position - center of the image (128),

% TODO 1
% Calculate the spatial frequency of the peaks
m1 = 128-96;%
m2 = 128-120;%

% TODO 2
% What is the maximum spatial frequency in an image of 256x256 pixels?

N=256;
m=1; % TODO 2
out1 = real(im1)*cos(2*pi*m/N*xx([256 256],'true'));
dipshow(out1)
ft(out1)

out2 = real(im2)*cos(2*pi*m/N*xx([256 256],'true'));
dipshow(out2)
ft(out2)

% TODO 3
% Compute images with the estimated frequencies of TODO 1 and compare them
% with the IFT of the input



%TODO 4
a = readim;
b = ft(a);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem #2  Demo            Fourier transform and filtering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear;

% Read the input image
im_color = readim('Zebra.jpg') % the input image clearly shows jpg compression artifacts in the back (false colors)
im = (im_color{1}+im_color{2}+im_color{2})/3 

% Compute fourier transform of the image using dipimage
Fim = ft(im); 
dipshow(Fim)

% Creating hard-low pass filter in frequency domain 
% TODO 5
N = size(im);
hard_low = [];
dipshow(hard_low)
title('Hard Lowpass filter')

out1=[];
dipshow(out1) 
title('Hard Low') 


%  Creating soft-low pass filter in frequency domain 
N = size(im);
soft_low=[];
dipshow(soft_low)
title('Soft Lowpass filter')

out2 = [];
dipshow(out2) 
title('Soft Low') 

%  Creating soft-high pass filter in frequency domain 
% TODO 6

title('Soft High') 

%check that low and high sum up to the original




soft_low=zeros(N);
for i=1:N
    for j=1:N
       x=sqrt(i^2+j^2);
       soft_low(i,j) = 255*exp(-x/1000);
    end
end
dipshow((soft_low))
title('Soft Lowpass filter')

out2 = (ift(Fim.*soft_low));
dipshow(out2) 
title('Soft Low')