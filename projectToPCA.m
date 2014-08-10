function [ProjectedImages, ProjectedTestImage] = projectToPCA( test,m, A, Eigenfaces, k)

%%%%%%%%%%%%%%%%%%%%%%%% Projecting centered image vectors into facespace
% All centered images are projected into facespace by multiplying in
% Eigenface basis's. Projected vector of each face will be its corresponding
% feature vector.
eigenNum = size(Eigenfaces, 2);
Eigenfaces = Eigenfaces(:,eigenNum-k:eigenNum);

ProjectedImages = [];
Train_Number = size(A,2);
for i = 1 : Train_Number
    temp = Eigenfaces'*A(:,i); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; 
end

%%%%%%%%%%%%%%%%%%%%%%%% Extracting the PCA features from test image
%InputImage = imread(TestImage);
%temp = InputImage(:,:,1);

%[irow, icol] = size(temp);
%InImage = reshape(temp',irow*icol,1);

num = numel(test(1,:));
Difference = double(test)-m*ones(1,num); % Centered test image
ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector