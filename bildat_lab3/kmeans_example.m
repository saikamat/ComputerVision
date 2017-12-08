clc
clear all

K = 8;               % number of clusters used
L = 10;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

I = im2double(imread('orange.jpg'));
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

%tic
%[ segm, centers ] = kmeans_segm(I, K, L, seed);
centers = I( ceil(rand(K,1)*size(I,1)) ,:);
DAL   = zeros(size(I,1),K+2); 

for n = 1:L
   for i = 1:size(I,1)
      for j = 1:K  
        DAL(i,j) = norm(I(i,:) - centers(j,:));      
      end
      [Distance, CN] = min(DAL(i,1:K));               % 1:K are Distance from Cluster Centers 1:K 
      DAL(i,K+1) = CN;                                % K+1 is Cluster Label
      DAL(i,K+2) = Distance;                          % K+2 is Minimum Distance
   end
   for i = 1:K
      A = (DAL(:,K+1) == i);                          % Cluster K Points
      centers(i,:) = mean(I(A,:));                      % New Cluster Centers
      if sum(isnan(centers(:))) ~= 0                    % If CENTS(i,:) Is Nan Then Replace It With Random Point
         NC = find(isnan(centers(:,1)) == 1);           % Find Nan Centers
         for Ind = 1:size(NC,1)
         centers(NC(Ind),:) = I(randi(size(I,1)),:);
         end
      end
   end
end

X = zeros(size(I));
for i = 1:K
idx = find(DAL(:,K+1) == i);
X(idx,:) = repmat(centers(i,:),size(idx,1),1); 
end

segm = K;
%toc
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/kmeans1.png')
imwrite(I,'result/kmeans2.png')

figure()
subplot(121); imshow(I); title('original')
subplot(122); imshow(Inew); title('segmented')
disp('number of segments ='); disp(K)


%%
%ORIGINAL CODE: don't touch
clc
clear all

K = 8;               % number of clusters used
L = 10;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

I = imread('orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/kmeans1.png')
imwrite(I,'result/kmeans2.png')

figure()
subplot(121); imshow(I); title('original')
subplot(122); imshow(Inew); title('segmented')
disp('number of segments ='); disp(K)