%cropping the header
addpath('/Users/hellen/workspace/data_acquisition/pdf2jpg-melhor resolucao/subtracao/')
%fnames = dir('/Users/hellen/workspace/data_acquisition/pdf2jpg-melhor resolucao/subtracao/*.jpg');

for i=1:length(fnames)
   file = fnames(i).name;
   img_raw = imresize(imread(file),0.8);
   img_cropped = imcrop (img_raw,[0 250 993 980]);
   figure;
   imshow(img_cropped)
   new_name = strcat('cropped/',file);
   imwrite(img_cropped, new_name, 'jpg')
end
