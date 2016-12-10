addpath('/Users/hellen/workspace/data_acquisition/pdf2jpg-melhor resolucao/subtracao/cropped')
fnames = dir('/Users/hellen/workspace/data_acquisition/pdf2jpg-melhor resolucao/subtracao/cropped/*.jpg');
% reading in grayscale and adjusting contrast
for i=1:length(fnames)
   file = fnames(i).name;
   
   img_raw = rgb2gray(imresize(imread(file),1));
   img_edit = imadjust(img_raw,[0.3 0.9],[]);
   new_name = strcat('contrast/',file);
   imwrite(img_edit, new_name, 'jpg')
   %figure;
   %subplot(1,2,1);
   %imshow(img_raw)
   %subplot(1,2,2);
   %imshow(img_edit)
end    

