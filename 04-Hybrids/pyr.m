function [gau lap]=pyr(im,sigma,par)

im=double(im);
[m n o]=size(im);
lap=zeros(m,n,o);
Af=zeros(m,n,o);
% selection of gaussian filter
gfilt=fspecial('gaussian',5,sigma);
if strcmp('up',par)==1
    for i=1:3 %Convolution for each color channel
    Af(:,:,i)=conv2(im(:,:,i),gfilt,'same');
    end
    %resizing the image
    gau=imresize(Af,2,'bilinear');
    lap=[];
else
    for i=1:3 %Convolution for each color channel
    Af(:,:,i)=conv2(im(:,:,i),gfilt,'same');
    end
    %Reduction
    G1A1=Af(1:2:end,1:2:end,:);
    %Laplacian 
    lap=imsubtract(im,imresize(G1A1,2,'bilinear'));
    gau=G1A1;
end
gau=uint8(gau);
end