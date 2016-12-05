cd '/Users/hellen/workspace/supercamera/data_acquisition/pdf2jpg-melhor resolucao/subtracao/cropped and contrast'
fnames = dir('/Users/hellen/workspace/supercamera/data_acquisition/pdf2jpg-melhor resolucao/subtracao/cropped and contrast/*.jpg');
for indice=1:length(fnames)
    file = fnames(indice).name;
    testProgram(file);
    fprintf('Did it for %d image(s) \n',indice);
end