
%% s2: Spatial Measure of Sharpness
% % Read the input image
% im_color = readim('Tiger.jpg'); % the input image clearly shows jpg compression artifacts in the back (false colors)
% 
% %Convert colored picture to grayscale via a pixel-wise transformation
% im = 0.2989*im_color{1}+0.5870*im_color{2}+0.1140*im_color{2};


% Read the input image
im_color = imread('Tiger.jpg'); % the input image clearly shows jpg compression artifacts in the back (false colors)

%Convert colored picture to grayscale via a pixel-wise transformation
im = 0.2989*im_color(:,:,1)+0.5870*im_color(:,:,2)+0.1140*im_color(:,:,3);
% im1=im(1:2036,1:1524);


im1=im(1:1524,1:2036);
m2=8;
d2=4;
[x1,x2]=size(im1);
p=(x1-d2)/(m2-d2);
q=(x2-d2)/(m2-d2);
vx=zeros(size(im1));


for i=1:x1
    for j=1:x2
        if i>=2&&i<=(x1-1)&&j>=2&&j<=(x2-1)
            m = [im1(i-1,j-1) im1(i-1,j) im1(i-1,j+1) im1(i,j-1)  im1(i,j+1) im1(i+1,j-1) im1(i+1,j) im1(i+1,j+1)];
%             size(m)
            n = [1 2 3 4 5 6 7 8];
            col = nchoosek(n,2);
            m_col_diff = abs(m(:,col(:,1)) - m(:,col(:,2)));
            vx(i,j)=sum(m_col_diff)/255;
        else
            vx(i,j)=im1(i,j)/255;
        end
    end
end


S2=zeros(size(im1));
for i=1:p
    for j=1:q
%         j*(m-d)+d
        vxblock=vx((i-1)*(m2-d2)+1:(i*(m2-d2)+d2),(j-1)*(m2-d2)+1:(j*(m2-d2)+d2));
        Vxblockvalue(i,j)=max(max(vxblock));
    end
end

for i=1:p
    for j=1:q
        if i<=(p-1)&&j<=(q-1)
          TV=(Vxblockvalue(i,j)+Vxblockvalue(i,j+1)+Vxblockvalue(i+1,j)+Vxblockvalue(i+1,j+1))/4;
          S2((i-1)*(m2-d2)+1:(i*(m2-d2)+d2),(j-1)*(m2-d2)+1:(j*(m2-d2)+d2))=TV.*ones(2*(m2-d2),2*(m2-d2));
        else
            TV=Vxblockvalue(i,j);
            S2((i-1)*(m2-d2)+1:(i*(m2-d2)+d2),(j-1)*(m2-d2)+1:(j*(m2-d2)+d2))=TV.*ones(2*(m2-d2),2*(m2-d2));
        end
    end
end
imshow(S2);
