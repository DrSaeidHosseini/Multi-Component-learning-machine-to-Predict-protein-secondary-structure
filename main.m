tic
clc;
clear;
close all;

data = cell2mat(struct2cell(load('data1.mat')));
data(101:end,:) = [];
dataLab = cell2mat(struct2cell(load('lable1.mat')));
dataLab(101:end,:) = [];
svmFinalLab = cell2mat(struct2cell(load('svmLab1.mat')));
svmFinalLab(101:end,:) = [];

dim = size(data,1);
finalLab = zeros(dim,1);
finalLab1 = zeros(dim,1);
finalLab2 = zeros(dim,1);
finalLab3 = zeros(dim,1);
finalLab4 = zeros(dim,1);
finalLab5 = zeros(dim,1);

finalAcc = zeros(6,10);
testFuzMemship = zeros(3,dim);
testIndArr = cell(10,1);
c = cvpartition(dataLab,'kfold',10);

for z = 1:10
z
trainInd = find(c.training(z)==1);
testInd = find(c.test(z)==1);
train = data(trainInd,:);
test = data(testInd,:);

testLab = dataLab(testInd,1);
trainLab = dataLab(trainInd,1);

svm_preLab = svmFinalLab(testInd,1);

trainDim = size(train,1);
testDim = size(test,1);

c_val_train = zeros(trainDim,1);
c_val_test = zeros(testDim,1);

test_similar_criteria = zeros(trainDim,trainDim);
preLable1 = zeros(testDim,1);
preLable2 = zeros(testDim,1);
preLable3 = zeros(testDim,1);
preLable = zeros(testDim,1);
preLable4 = zeros(testDim,1);
preLable5 = zeros(testDim,1);


test_fuz_memship2 = zeros(6,testDim);
test_fuz_memship2(4,:) = '1';
test_fuz_memship2(5,:) = '2';
test_fuz_memship2(6,:) = '3';

parfor i=1:trainDim
    i
    c_val_train(i,1) = Ex_His(train(i,:));
end;

parfor y=1:testDim
    y
    c_val_test(y,1) = Ex_His(test(y,:));
end;


for q = 1:trainDim
    q
    parfor w = 1:trainDim
        w
        test_similar_criteria(q,w) = Distance(train(q,:),train(w,:),c_val_train(q,1),c_val_train(w,1));
    end;
end;

k_fuzz = 1;
init_fuz_memship = zeros(3,trainDim);


    
for m = 1: trainDim
    m
    [~, ind1] = sort(test_similar_criteria(m,:));
    neighborInd1 = ind1(1,1:k_fuzz);
    
    sam_class = trainLab(m,1);
%   1 = H , 2 = E , 3 = - or C
    sampNo1 = size(find(trainLab(neighborInd1)=='1'),1);
    sampNo2 = size(find(trainLab(neighborInd1)=='2'),1);
    sampNo3 = size(find(trainLab(neighborInd1)=='3'),1);
    
    if sam_class == '1'
         init_fuz_memship(1,m) = 0.51 + (sampNo1/k_fuzz)* 0.49;
         init_fuz_memship(2,m) = (sampNo2/k_fuzz) * 0.49;
         init_fuz_memship(3,m) = (sampNo3/k_fuzz)* 0.49;
    elseif sam_class == '2'
         init_fuz_memship(2,m) = 0.51 + (sampNo2/k_fuzz)* 0.49;
         init_fuz_memship(1,m) = (sampNo1/k_fuzz) * 0.49;
         init_fuz_memship(3,m) = (sampNo3/k_fuzz)* 0.49;
    else 
         init_fuz_memship(3,m) = 0.51 + (sampNo3/k_fuzz)* 0.49;
         init_fuz_memship(1,m) = (sampNo1/k_fuzz) * 0.49;
         init_fuz_memship(2,m) = (sampNo2/k_fuzz)* 0.49;
    end;
end;

k = 1;

neighborInd = zeros(testDim,k);

testDis = zeros(testDim,trainDim);

for t=1:testDim
    t
    parfor p=1:trainDim
        p
        testDis(t,p) = Distance(test(t,:),train(p,:),c_val_test(t,1),c_val_train(p,1));
    end;
end;
        
for j = 1:testDim
    j
    
    [val ind] = sort(testDis(j,:));
    neighborInd(j,1:k) = ind(1,1:k);
    
    [test_fuz_memship2(1:3,j)] = fk(neighborInd(j,:),k,val,init_fuz_memship);

      preLable(j,1) = fusion(test_fuz_memship2(:,j));
      preLable1(j ,1) = fusion1(svm_preLab(j,1),test_fuz_memship2(:,j));
      preLable2(j ,1) = fusion2(svm_preLab(j,1),test_fuz_memship2(:,j));
      preLable3(j ,1) = fusion3(svm_preLab(j,1),test_fuz_memship2(:,j));
      preLable4(j ,1) = fusion4(svm_preLab(j,1),test_fuz_memship2(:,j));
      preLable5(j ,1) = fusion5(svm_preLab(j,1),test_fuz_memship2(:,j));

end;


acc1 = ((sum(preLable1==testLab))/testDim)*100
acc2 = ((sum(preLable2==testLab))/testDim)*100
acc3 = ((sum(preLable3==testLab))/testDim)*100
acc4 = ((sum(preLable4==testLab))/testDim)*100
acc5 = ((sum(preLable5==testLab))/testDim)*100

accFKNN = ((sum(preLable==testLab))/testDim)*100

finalLab(testInd,1) = preLable;
finalLab1(testInd,1) = preLable1;
finalLab2(testInd,1) = preLable2;
finalLab3(testInd,1) = preLable3;
finalLab4(testInd,1) = preLable4;
finalLab5(testInd,1) = preLable5;

finalAcc(1,z) = accFKNN;
finalAcc(2,z) = acc1;
finalAcc(3,z) = acc2;
finalAcc(4,z) = acc3;
finalAcc(5,z) = acc4;
finalAcc(6,z) = acc5;

testFuzMemship(:,testInd) = test_fuz_memship2(1:3,:);

testIndArr{z} = testInd;

end;

save('finalLabF1.mat','finalLab');   
save('finalLab1F1.mat','finalLab1');
save('finalLab2F1','finalLab2');
save('finalLab3F1.mat','finalLab3');
save('finalLab4F1','finalLab4');
save('finalLab5F1','finalLab5');
save('finalAccF1.mat','finalAcc');
save('testFuzMemshipF1.mat','testFuzMemship');
save('testIndArrF1.mat','testIndArr');
toc

