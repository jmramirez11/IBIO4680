%Agrega la carpeta de imagenes al directorio
addpath(genpath('imagenes_lab4'));
%lista las imagenes de dicho directorio
lista = dir('imagenes_lab4');
%Se realiza un for que recorre las imagenes de la carpeta por parejas y 
%crea la imagen hibrida y calcula la piramide gaussiana. 
%Se inicializa el vector de sigmas
sigma = [0,0,10,3,20,8,20,8];
for i=3:2:numel(lista)/1
  %Se leen las imagenes y se reescalan para que queden del mismo tama;o
    ima1 = imread(lista(i).name);
    ima2 = imread(lista(i+1).name);
    ima1 = imresize(ima1,[size(ima2,1),size(ima2,2)]); 
  %Filtrado de la imagen 1 con pasa bajas 
    imf1 = imgaussfilt(ima1,sigma(i));
  %sigma para el filtro pasa altas de la imagen 2
    sigma_hp = 3;
  %Filtrado pasa bajas de la imagen 2   
    imf2 = imgaussfilt(ima2,sigma(i+1));
  %Se resta la imagen anterior de la original para obtener la pasa altas
    imf2 = imsubtract(ima2,imf2);
  %Se calcula la imagen hibrida
    imfinal = imf2+imf1;
  %Se calcula la piramide gaussiana (5 scales)
    final1 = impyramid(imfinal,'reduce');
    final2 = impyramid(final1,'reduce');
    final3 = impyramid(final2,'reduce');
    final4 = impyramid(final3,'reduce');
    final5 = impyramid(final4,'reduce');
  %Se guardan las imagenes en un cell array para mostrarlas
    cell_ima = {};
    cell_ima{1} = imfinal;
    cell_ima{2} = final1;
    cell_ima{3} = final2;
    cell_ima{4} = final3;
    cell_ima{5} = final4;
    cell_ima{6} = final5;
  %Se procede a mostrar las imagenes
    m = size(cell_ima{1}, 1);
    newI = cell_ima{1};
    for j = 2 : numel(cell_ima)
        [q,p,~] = size(cell_ima{j});
        cell_ima{j} = cat(1,repmat(zeros(1, p, 3),[m - q , 1]),cell_ima{j});
        newI = cat(2,newI,cell_ima{j});
    end
    figure;imshow(newI)
end