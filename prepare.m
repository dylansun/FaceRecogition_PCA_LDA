str='C:\Users\Administrator\Desktop\att_faces'; %图像存放路径
train=[];%training set
for i=1:40
    for j=1:7
        img=imread([str,'\s',num2str(i),'\',num2str(j),'.pgm']); %依次读取每一幅图像
        %img=rgb2gray(img);
        if size(img,3) > 1
            img = rgb2gray(img);
        end
        [irow, icol] = size(img);
        img2 = im2double(img); 
        temp = reshape(img2',irow * icol , 1);
        train = [train temp];% 'T' grows after each turn
    end
end

test=[];%training set
for i=1:40
    for j=8:10
        img=imread([str,'\s',num2str(i),'\',num2str(j),'.pgm']); %依次读取每一幅图像
        if size(img,3)>1
            img=rgb2gray(img);
        end 
        [irow, icol] = size(img);
        img2 = im2double(img);
        temp = reshape(img2',irow * icol , 1);
        test = [test temp];% 'T' grows after each turn
    end
end


label_train = zeros(40*7,40);
for i = 1:40
    for j = 1:7
        label_train(7*(i-1)+j,i)=1;
    end
end
label_test = zeros(40*3, 40);
for i=1:40
    for j = 1: 3
        label_test(3*(i-1)+j,i) = 1;
    end 
end
clear i j irow icol img str temp img2
save('data\TrainTest.mat', 'label_test', 'label_train', 'nClass', 'nEachClass');