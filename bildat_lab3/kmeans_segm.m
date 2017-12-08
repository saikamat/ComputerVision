
function [ segm, centers ] = kmeans_segm(I, K, L, seed)

%K     = 8;                                            % Cluster Numbers
centers = I( ceil(rand(K,1)*size(I,1)) ,:);             % Cluster Centers
DAL   = zeros(size(I,1),K+2);                         % Distances and Labels
%KMI   = 10;                                           % K-means Iteration
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
%T = reshape(X,size(I,1),size(I,2),3);
%% Show
% figure()
% subplot(121); imshow(I); title('original')
% subplot(122); imshow(T); title('segmented')
% disp('number of segments ='); disp(K)