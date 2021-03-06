function [ ] = testProgram(nome)
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
    %input('Press enter');
    fprintf('Finished K-means...\n');
    bounded_img_list = cell(chars.NumObjects);
    for index=1:chars.NumObjects
        bounded_img_list{index} = ...
            findBoundingBox(reshape(img_list(index,:),chars.ImageSize) );
        %figure;
        %imshow(bounded_img_list{index});
    end

    %% resizing all the objects to 28x28
    num_objects = 0; %%number of valid objects
    mnistlike_bounded_list = cell(0); %initilizing list

    for index=2:chars.NumObjects % object #1 is the background?
        img_ind = bounded_img_list{index};
        img_size = size(img_ind);
        img_ind = img_ind/max(img_ind(:)); %normalizing

        if ((img_size (1) > 1) && (img_size (2) > 1) && (img_size (1) < 80) && (img_size (2) < 80))
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
                %display(img_size);
                %display(smaller);
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
    fprintf('Finished resizing...\n');
    
    %% saving individual images
    id = nome(1:end-4);
    mkdir(id);
    for i=1:length(mnistlike_bounded_list)
        image = mnistlike_bounded_list{i};
        %image = mat2gray(mnistlike_bounded_list{i}); %getting rid of
        %negative values > too noisy!
        %image = imbinarize(image); %just in case we want BW image
        new_name = strcat(id, '/', id,'-',sprintf('%03d',i),'.jpg');
        imwrite (image, new_name, 'jpg'); 
    end

end