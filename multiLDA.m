nClass = 40;
nEachClass = 7;
[nFea, N]= size(ProjectedImages);

mu = zeros(nFea, nClass);
avg = mean(ProjectedImages,2);
for i = 1: nClass
    mu(:,i) = mean(ProjectedImages(:,(i-1)*nEachClass+ 1:(i-1)*nEachClass+nEachClass),2);
end

sw = zeros(nFea,nFea);
for i = 1: nClass
    for j = 1: nEachClass
        x = ProjectedImages(:, (i-1)*nEachClass+j);
        sw = sw+(x-mu(i))*(x-mu(i))';
    end
end

sb=zeros(nFea,nFea);
for i = 1:nClass
    sb = sb + nEachClass*((mu(i)-avg)*(mu(i)-avg)');
end


%invsw = inv(sw);
%v=invsw*sb;

% find eigne values and eigen vectors of the (v)
[evec,eval]=eig(sb,sw);