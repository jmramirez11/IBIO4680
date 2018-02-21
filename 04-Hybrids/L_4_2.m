clc 
clear all
close all
%Read original images
A=imread('Mar.jpg');
B=imread('Fra.jpg');
%Reduce
red_A=impyramid(impyramid(impyramid(A,'reduce'),'reduce'),'reduce');
red_B=impyramid(impyramid(impyramid(B,'reduce'),'reduce'),'reduce');
%Concatenate
[m n o]=size(red_A);
baund=ceil(n/2);
ABcat=[red_A(:,1:baund,:) red_B(:,baund:end,:)];
% Rise pyramid
ABmix=pyr(ABcat,2,'up');
ABmix=imadd(ABmix,imsubtract(ABmix,pyr(pyr(ABmix,2,'down'),2,'up')));
ABmix=pyr(ABmix,2,'up');
ABmix=imadd(ABmix,imsubtract(ABmix,pyr(pyr(ABmix,2,'down'),2,'up')));
ABmix=pyr(ABmix,2,'up');
ABmix=imadd(ABmix,imsubtract(ABmix,pyr(pyr(ABmix,2,'down'),2,'up')));
ABmix=pyr(ABmix,2,'up');
ABmix=imadd(ABmix,imsubtract(ABmix,pyr(pyr(ABmix,2,'down'),2,'up')));

imshow(ABmix)



%%


CRA=A(:,:,1);
CGA=A(:,:,2);
CBA=A(:,:,3);
CRB=B(:,:,1);
CGB=B(:,:,2);
CBB=B(:,:,3);
