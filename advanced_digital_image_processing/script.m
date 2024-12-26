% Progrmming assignment for AP3132-Advanced Digital Image Processing course
% Instructor: B. Rieger, F. Vos 
% Tutor: H. Heydarian
% Term: Q3-2021
%
% Labwork #2
%
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem #1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part a: dilation and erosion

% read the original input image
% I = readim(['images' filesep 'gold.tif']);
I = readim('gold.tif');
h=dipshow(I);
h.Name='original image';
h.NumberTitle='off';

% add proper noise to make the image the same as the one depicted in the 
% manual (top-right in Figure 1)
% TODO3
J = noise(I,'saltpepper',0,0.1);
h = dipshow(J);
h.Name='noisy image';
h.NumberTitle='off';

% apply dilation to the noisy image
In = J;
I_max = max_f(In, 3);
h=dipshow(I_max);
h.Name='dilated image';
h.NumberTitle='off';

% apply erossion to the noisy image
I_min = min_f(In, 3);
h=dipshow((I_min));
h.Name='eroded image';
h.NumberTitle='off';

pause
%%
% Part b: closing and opening

% apply closing to the given image
% TODO4a

I_close =min_f(max_f(In, 3),3);

h=dipshow(I_close);
h.Name='closing';
h.NumberTitle='off';

% apply openning to the given image
% TODO4b
I_open =max_f(min_f(In, 3),3);

h=dipshow(I_open);
h.Name='opening';
h.NumberTitle='off';
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem #2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part a: smoothing

% read the original input image
% I = readim(['images' filesep 'trui.tif']);
I = readim('trui.tif');
h=dipshow(I);
h.Name='original image';
h.NumberTitle='off';

% TODO5
% add proper noise to make the image as depicted in the lecture notes
J = noise(I,'gaussian',10);
h=dipshow(J);
h.Name='noisy image';
h.NumberTitle='off';

In = J;
I_max = max_f(In, 3);
I_min = min_f(In, 3);

Iout1=(I_max+I_min)/2;

h=dipshow(Iout1);
h.Name='smoothed image (method1)';
h.NumberTitle='off';

I_close =min_f(max_f(In, 3),3);
I_open =max_f(min_f(In, 3),3);
Iout2=(I_close+I_open)/2;

h=dipshow(Iout2);
h.Name='smoothed image (method2)';
h.NumberTitle='off';

pause
%%
% Part b: image gradient

% read the original input image
% I = readim(['images' filesep 'truinoise.tif']);
I = readim('truinoise.tif');
h=dipshow(I);
h.Name='original image';
h.NumberTitle='off';

% TODO6

% structuring element size
k = 9;

% TODO6a
% dilation
I_di = max_f(I, k);
% erosion
I_er = min_f(I, k);
% openning
I_op = max_f(I_er, k);
% closing
I_cl = minf(I_di, k);

% image gradient method 1 TODO6b
dyr = I_di-I_er;%I-(I_di+I_er)/2;
h=dipshow(dyr);
h.Name='gradient  dyr';
h.NumberTitle='off';

% image gradient method 2 TODO6c
ter = I_op-I_cl;%I-(I_op+I_cl)/2;
h=dipshow(ter);
h.Name='gradient  ter';
h.NumberTitle='off';

% image gradient method 3 TODO6d
rar = (I_op-I_cl)+(I_di-I_er);%(I_op-I_cl)/2+(I_di-I_er)/2;
h=dipshow(rar);
h.Name='gradient image rar';
h.NumberTitle='off';

% compare with gradmag() from diplib
gradmag_pic=gradmag(I);
h=dipshow(gradmag_pic);
h.Name='gradient image gradmag_pic';
h.NumberTitle='off';
%%
% Part c: Background removal

% read the original input image
% I = readim(['images' filesep 'retinaangio.tif']);
I = readim('retinaangio.tif');
h=dipshow(I,'lin');
h.Name='original image';
h.NumberTitle='off';

% TODO7
% structuring element size
k = 23;

% TODO6a
% dilation
I_di = max_f(I, k);
% erosion
I_er = min_f(I, k);
% openning
I_op = max_f(I_er, k);
% closing
I_cl = minf(I_di, k);
% bg=I_er;
% nobg=I_cl;
bg=I_cl;
nobg=I-I_op;

h=dipshow(bg,'lin');
h.Name='background';
h.NumberTitle='off';

h=dipshow(nobg,'lin');
h.Name='background removed';
h.NumberTitle='off';
