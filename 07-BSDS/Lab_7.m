% clc
% clear all
% close all

im_test_path=fullfile(pwd,'BSR','BSDS500','data','images','test');
im_train_path=fullfile(pwd,'BSR','BSDS500','data','images','train');
im_val_path=fullfile(pwd,'BSR','BSDS500','data','images','val');

if (exist('Results')==7)==0
    mkdir('Results');
    mkdir(fullfile(pwd,'Results','Kmeans'));
    mkdir(fullfile(pwd,'Results','Kmeans','test'));
    mkdir(fullfile(pwd,'Results','Kmeans','train'));
    mkdir(fullfile(pwd,'Results','Kmeans','val'));
    
    mkdir(fullfile(pwd,'Results','Hierarchical'));
    mkdir(fullfile(pwd,'Results','Hierarchical','test'));
    mkdir(fullfile(pwd,'Results','Hierarchical','train'));
    mkdir(fullfile(pwd,'Results','Hierarchical','val'));
end

test_im=dir(fullfile(im_test_path,'**\*.jpg'));
train_im=dir(fullfile(im_train_path,'**\*.jpg'));
val_im=dir(fullfile(im_val_path,'**\*.jpg'));

for i=1:length(test_im)
    im=imread(fullfile(test_im(i).folder,test_im(i).name));
    seg_1=cell(1,17);
    for j=2:17
    [out_1]=segmentByClustering(im,'hsv+xy','kmeans',j);
    seg_1{j}=out_1;
    end
    namae=erase(test_im(i).name,'.jpg');
    save(fullfile(pwd,'Results','Kmeans','test',[namae '.mat']),'seg_1');
end
for i=1:length(train_im)
    im=imread(fullfile(train_im(i).folder,train_im(i).name));
    seg_1=cell(1,17);
    for j=2:17
    [out_1]=segmentByClustering(im,'hsv+xy','kmeans',j);
    seg_1{j}=out_1;
    end
    namae=erase(train_im(i).name,'.jpg');
    save(fullfile(pwd,'Results','Kmeans','train',[namae '.mat']),'seg_1');
end
%%
for i=81:length(val_im)
    im=imread(fullfile(val_im(i).folder,val_im(i).name));
    seg_1=cell(1,17);
    for j=2:17
    [out_1]=segmentByClustering(im,'hsv+xy','kmeans',j);
    seg_1{j}=out_1;
    end
    namae=erase(val_im(i).name,'.jpg');
    save(fullfile(pwd,'Results','Kmeans','val',[namae '.mat']),'seg_1');
end