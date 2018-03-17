addpath('BSR');addpath('BSR/bench_fast/benchmarks');addpath(genpath('BSR/BSDS500'));addpath(genpath('Results'));
nthresh = 99;
%Estas carpetas se varían según el m+etodo y el set de imágenes que se
%estén evaluando
imgDir = 'BSR/BSDS500/data/images/val';
gtDir = 'BSR/BSDS500/data/groundTruth/val';
inDir = 'Results/GMM/val';
% inDir='BSR/BSDS500/ucm2/val';
outDir = 'Eval_test/ucm2/val';
%Se crea el directorio en donde se guardará la información necesaria para
%graficar la curva de precisión y cobertura, para sacar al F medida, el
%área bajo la curva, etc.
mkdir(outDir);
addpath(genpath('Eval_test'))
%Se calcula dicha información y se guarda en el directorio outDir
tic;
allBench_fast(imgDir, gtDir, inDir, outDir, nthresh);
toc;
%Se grafica y se obtienen las medidas mencionadas
plot_eval(outDir)