nome = './coco.jpg';
[chars, clean] = detectCharacters(nome,30);
imshow(~clean);
% return;
Z = zeros(chars.ImageSize);
img_list = zeros(chars.NumObjects,prod(chars.ImageSize));
for index=1:chars.NumObjects
    img = Z;
    img(chars.PixelIdxList{index}) = 1;
    img_list(index,:) = img(:);
end
% return;
input('Press enter');
bounded_img_list = cell(chars.NumObjects);
for index=1:chars.NumObjects
    bounded_img_list{index} = ...
        findBoundingBox( reshape(img_list(index,:),chars.ImageSize) );
    figure;
    imshow(bounded_img_list{index});
end