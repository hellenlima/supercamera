cd '/Users/hellen/workspace/supercamera/data_acquisition/pdf2jpg-melhor resolucao/multiplicacao/contrast and cropped'
nome = '02.jpg';
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
        findBoundingBox(reshape(img_list(index,:),chars.ImageSize) );
    figure;
    imshow(bounded_img_list{index});
end

%% resizing all the objects to 28x28
num_objects = 0; %%number of valid objects
mnistlike_bounded_list = cell(0); %initilizing list

for index=2:chars.NumObjects % object #1 is the background?
    img_ind = bounded_img_list{index};
    img_size = size(img_ind);
    img_ind = img_ind/max(img_ind(:)); %normalizing

    if ((img_size (1) > 2) && (img_size (2) > 2))
        num_objects = num_objects+1;
        if img_size(1) > img_size(2) 
            ratio = img_size(2)/img_size(1);
            smaller = round(20*ratio);
            resized = imresize(img_ind, [20 smaller]); %to make 20 be the biggest dimension
            difference = (28 - smaller);
            x = round(difference/2);
            if (mod(difference,2)==1) %if difference is odd
                comp_begin = zeros(20,x);
                comp_end = zeros(20,x-1);
            else %if difference is even
                comp_begin = zeros(20,x);
                comp_end = comp_begin;
            end
            comp_1 = [comp_begin resized comp_end];
            comp_begin = zeros(4,28);
            comp_end = comp_begin;
            final = [comp_begin; comp_1; comp_end];
        else % img_size(2) > img_size(1)
            ratio = img_size(1)/img_size(2);
            smaller = round(20*ratio);
            resized = imresize(img_ind, [smaller 20]);
            difference = (28 - smaller);
            x = round(difference/2);
            if (mod(difference,2)==1) %if t is odd
                comp_begin = zeros(x,20);
                comp_end = zeros(x-1,20);
            else
                comp_begin = zeros(x,20);
                comp_end = comp_begin;
            end
            comp_1 = [comp_begin; resized; comp_end];
            comp_begin = zeros(28,4);
            comp_end = comp_begin;
            final = [comp_begin comp_1 comp_end];
        end
        mnistlike_bounded_list{num_objects} = final;
    end %%end eliminating lines 
end %%end for
%% proximo passo: salvar cada caracter como um jpg, cujo nome ? 'identificador-contador.jpg'
%por exemplo: '01-003.jpg'