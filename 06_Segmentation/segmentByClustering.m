function [segmentation] = segmentByClustering(im,featureSpace,clusteringMethod,numberOfClusters)
if numberOfClusters<2
    error('The number of clusters must be >=2');
end
[m n o]= size(im);
x=ones(m,n).*(1:m)';
y=ones(m,n).*(1:n);
segmentation=zeros(m,n);
if strcmp(featureSpace,'hsv')
    new_im=rgb2hsv(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)'];
elseif strcmp(featureSpace,'lab')
    new_im=rgb2lab(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)'];
elseif strcmp(featureSpace,'hsv+xy')
    new_im=rgb2hsv(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)' x(:)/m y(:)/n];
elseif strcmp(featureSpace,'lab+xy')    
    new_im=rgb2lab(im);  
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)' x(:)/m y(:)/n];
elseif strcmp(featureSpace,'rgb+xy')
    new_im=double(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)' x(:)/m y(:)/n];
else
    new_im=double(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)'];
end

switch clusteringMethod
    case 'kmeans'
        [class,~] = kmeans(pix_dat,numberOfClusters,'distance','sqEuclidean','Replicates',3);
        segmentation = reshape(class,m,n);        
    case 'gmm'
        gm = fitgmdist(pix_dat,numberOfClusters);
        idx = cluster(gm,pix_dat);
        segmentation = reshape(idx,m,n);        
    case 'hierarchical'
        ki=linkage(double(pix_dat),'ward','euclidean','savememory','on');
        [~,T]=dendrogram(ki,numberOfClusters);
        segmentation(:)=T(:);
    case 'watershed'
        segmentation=cell(1,4);
        for i = 1:4
            if i==4
            bw=double(rgb2gray(im));
            [M D]=imgradient(bw,'sobel');
            Mark =imextendedmin(double(M),numberOfClusters);
            new=imimposemin(double(M),Mark);
            wat=watershed(new);
            segmentation{i}=max(zeros(m,n),numberOfClusters*(wat==0));
      
                break
            end
            bw=double(new_im(:,:,i));
            [M D]=imgradient(bw,'sobel');
            Mark =imextendedmin(M,numberOfClusters);
            new=imimposemin(M,Mark);
            wat=watershed(new);
            segmentation{i}=max(zeros(m,n),numberOfClusters*(wat==0));
        end
end

end