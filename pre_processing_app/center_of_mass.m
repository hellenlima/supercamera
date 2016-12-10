%calculate the center of mass of an image, without using matlab functions
function [ cm_x, cm_y ] = center_of_mass (data)
    %data = [0,0,0.3; 0,0.7,0; 0.5,0,0];

    sum_x = 0;
    sum_y = 0;
    total = 0;
    
    % calculating the total mass
    for y=1:size(data,2)
        for x=1:size(data,1)
            total = total + data(x,y);   
        end
    end

    for y=1:size(data,2)
        for x=1:size(data,1)
            sum_x = sum_x + y*data(x,y)/total;
            sum_y = sum_y + x*data(x,y)/total;   
        end
    end
    %cm_x = round(sum_x); %rouding to the nearest integer
    cm_x = sum_x;
    cm_y = sum_y;
    %cm_y = round(sum_y);
end