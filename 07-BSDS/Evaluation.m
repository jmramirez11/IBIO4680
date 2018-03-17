addpath('BSR');addpath('BSR/bench_fast/benchmarks');addpath(genpath('BSR/BSDS500'));addpath(genpath('Results'));
nthresh = 99;
%Estas carpetas se var�an seg�n el m+etodo y el set de im�genes que se
%est�n evaluando
imgDir = 'BSR/BSDS500/data/images/val';
gtDir = 'BSR/BSDS500/data/groundTruth/val';
inDir = 'Results/GMM/val';
% inDir='BSR/BSDS500/ucm2/val';
outDir = 'Eval_test/ucm2/val';
%Se crea el directorio en donde se guardar� la informaci�n necesaria para
%graficar la curva de precisi�n y cobertura, para sacar al F medida, el
%�rea bajo la curva, etc.
mkdir(outDir);
addpath(genpath('Eval_test'))
%Se calcula dicha informaci�n y se guarda en el directorio outDir
tic;
allBench_fast(imgDir, gtDir, inDir, outDir, nthresh);
toc;
%Se grafica y se obtienen las medidas mencionadas
plot_eval(outDir)