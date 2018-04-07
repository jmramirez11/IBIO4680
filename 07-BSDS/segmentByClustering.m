function [Segout] = RR_Segmentation(im,featSpc,clstMeth,k)
if k<2
    error('The number of clusters must be >=2');
end
[m n o]= size(im);
y=(1:m)'*ones(1,n);
x=ones(m,1)*(1:n);
Segout=zeros(m,n);
if strcmp(featSpc,'hsv')
    new_im=rgb2hsv(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)'];
elseif strcmp(featSpc,'lab')
    new_im=rgb2lab(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)'];
elseif strcmp(featSpc,'hsv+xy')
    new_im=double(rgb2hsv(im));
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)' x(:)/n y(:)/m];
elseif strcmp(featSpc,'lab+xy')    
    new_im=rgb2lab(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)' x(:)/n y(:)/m];
elseif strcmp(featSpc,'rgb+xy')
    new_im=double(im);
    pix_dat=[new_im(1:m*n)'/255 new_im(m*n+1:2*m*n)'/255 new_im(2*m*n+1:3*m*n)'/255 x(:)/n y(:)/m];
else
    new_im=double(im);
    pix_dat=[new_im(1:m*n)' new_im(m*n+1:2*m*n)' new_im(2*m*n+1:3*m*n)'];
end

switch clstMeth
    case 'kmeans'
        [class,~] = kmeans(pix_dat,k,'distance','sqEuclidean','Replicates',3);
        Segout = reshape(class,m,n);
    case 'gmm'
        gm = fitgmdist(pix_dat,k);
        idx = cluster(gm,pix_dat);
        Segout = reshape(idx,m,n);
        
    case 'hierarchical'
        ki=linkage(double(pix_dat),'ward','euclidean','savememory','on');
        [~,T]=dendrogram(ki,k);
        Segout(:)=T(:);
    case 'watershed'
        Segout=cell(1,4);
        for i = 1:4
            if i==4
            bw=double(rgb2gray(im));
            
            [M D]=imgradient(bw);
%             for h=1:10:256
            Mark =imextendedmin(double(M),k);
            new=imimposemin(double(M),Mark);
            wat=watershed(new);
            Segout{i}=max(zeros(m,n),k*(wat==0));
            figure(1);
            imshow(Segout{i});
            hold on
%             if 
%             end
%             end
            
            break
            end
            bw=double(new_im(:,:,i));
            [M D]=imgradient(bw);
            Mark =imextendedmin(M,k);
            new=imimposemin(M,Mark);
            wat=watershed(new);
            Segout{i}=max(zeros(m,n),k*(wat==0));
        end
end

end