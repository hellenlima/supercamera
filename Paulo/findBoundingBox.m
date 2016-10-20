
function [ out ] = findBoundingBox( image )
%CONVERTTESTSET Summary of this function goes here
%   Given a binary image array, this function will crop it to the
%   bounding box
    
    hold on;
    
    [rows, cols, ~] = find(image);
    
    min_y = floor(min(rows));
    max_y = floor(max(rows));
    min_x = floor(min(cols));
    max_x = floor(max(cols));
    
    drawLine([min_x min_y],[max_x min_y],'w');
    drawLine([min_x max_y],[max_x max_y],'w');
    drawLine([min_x min_y],[min_x max_y],'w');
    drawLine([max_x min_y],[max_x max_y],'w');
    
    hold off;      
    
    out = image(min_y:max_y,min_x:max_x);
end

