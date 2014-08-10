function accuracy = recognition_PCA( test,label_test,m, A, Eigenfaces)
% Recognizing step....
%
% Description: This function compares two faces by projecting the images into facespace and 
% measuring the Euclidean distance between them.
%
% Argument:      TestImage              - Path of the input test image
%
%                m                      - (M*Nx1) Mean of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                Eigenfaces             - (M*Nx(P-1)) Eigen vectors of the
%                                         covariance matrix of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                A                      - (M*NxP) Matrix of centered image
%                                         vectors, which is output of 'EigenfaceCore' function.
% 
% Returns:       OutputName             - Name of the recognized image in the training database.
%
% See also: RESHAPE, STRCAT

% Original version by Amir Hossein Omidvarnia, October 2007
%                     Email: aomidvar@ece.ut.ac.ir                  

%%%%%%%%%%%%%%%%%%%%%%%% Projecting centered image vectors into facespace
% All centered images are projected into facespace by multiplying in
% Eigenface basis's. Projected vector of each face will be its corresponding
% feature vector.

Eigenfaces = Eigenfaces(:,269:279);

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

%%%%%%%%%%%%%%%%%%%%%%%% Calculating Euclidean distances 
% Euclidean distances between the projected test image and the projection
% of all centered training images are calculated. Test image is
% supposed to have minimum distance with its corresponding image in the
% training database.

AvgProjectImage = [];
for i = 1:40
    q = ProjectedImages(:, (7*i-6):(7*i));
    temp = mean(q,2);
    AvgProjectImage=[AvgProjectImage temp];
end

Euc_dist = zeros(120,40);
for i = 1 : 120
    for j = 1:40
        q = AvgProjectImage(:,j);
        temp = ( norm( ProjectedTestImage(:,i) - q ) )^2;
        Euc_dist(i,j) = temp;
    end 
end

result = [];
for i = 1:120
        [~, index] = min(Euc_dist(i,:));
        temp = label_test(i,index);
        result = [result temp];
end

    
accuracy = sum(result) /120;
