function [ clean, out ] = detectCharacters(filename,T1)
%DETECTCHARACTERS Summary of this function goes here
%   given a filename, this function will split in a list of characters
%   contained in it
A = double(rgb2gray(imresize(imread(filename),0.5)));
A = A/max(A(:));
img_size = size(A);
X = reshape(A, img_size(1) * img_size(2),1);
max_iters = 10;
%initial_centroids = kMeansInitCentroids(X, K);
X = (X)/max(X(:));
minX = min(X(:));
maxX = max(X(:));
meanX = mean(X(:));
initial_centroids = [minX; meanX; maxX];
%initial_centroids =[minX; maxX];
[centroids] = runkMeans(X, initial_centroids, max_iters, false);
idx = findClosestCentroids(X, centroids);
X_recovered = centroids(idx,:);
X_recovered = double(reshape(X_recovered, img_size(1), img_size(2),1) >= centroids(2));
X_recovered = X_recovered - min(X_recovered(:));
out = ~(X_recovered/max(X_recovered(:)));

clean = bwareaopen(out,T1);
clean = bwconncomp(clean);
end

