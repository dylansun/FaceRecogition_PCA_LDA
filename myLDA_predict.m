eigenNum = size(evec, 2);
LDAEigenfaces = evec(:,eigenNum - 99:eigenNum);
train_LDA  = LDAEigenfaces' * ProjectedImages;
test_LDA = LDAEigenfaces' * ProjectedTestImage;

mu_LDA = [];
for i = 1:nClass;
    temp = mean(train_LDA(:, (i-1)*nEachClass+1:(i-1)*nEachClass+nEachClass),2);
    mu_LDA = [mu_LDA temp];
end

Euc_dist = zeros(120,40);
for i = 1 : 120
    for j = 1:40
        q = mu_LDA(:,j);
        temp = ( norm( test_LDA(:,i) - q ) )^2;
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