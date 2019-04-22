
% function [predic_lable] = fk(dim,lable,neighborInd,k,val,testInd)pish az
% fusion
function [fuz_vals] = fk(neighborInd,k,val,init_fuz_memship)

% global  test_fuz_memship2 init_fuz_memship numerator2 denominator2;

% global test_fuz_memship test_fuz_memship2 init_fuz_memship;
% tic
% clc;
% clear;
% close all;
% 
% lable = load('char_pro_class.mat');
% lable = struct2cell(lable);
% lable = cell2mat(lable);
% lable = char(lable);
% lable(11:end) = [];
% data = load('protein_seq_dashfree.mat');
% data = struct2cell(data);
% data{1}(11:end) = [];
% % data = char(cell2mat(data));
% 
% dim = size(data{1},1);
% c_val = zeros(dim,1);
% % k_mem = 10;
% % k_clas = 0;
% lz = zeros(1,dim);
% 
% for i=1:10
%     c_val(i,1) = Ex_His(data{1}{i,:});
% end;

% neighbors = cell(k_fuzz);
% init_fuz_memship = zeros(3,dim);
% sampNo = zeros(1,3);

%  initialize the fuzzy membership values of training data
% for i = 1:dim
%     for j = 1:dim 
%         lz(i,j) = Distance(data{1}(i,:),data{1}(j,:),c_val(i,1),c_val(j,1));
%     end;
%     lz(i,i) = 100;
%     [val ind] = sort(lz(1,:));
%     neighbors = data{1}(ind(1:k_fuzz));

% ........................................................................

% start of the prediction phase

% row = size(data{1},1);
% col = size(pros,2);
% c = cvpartition(dim,'leaveout');
% train = cell(dim);
% test = cell(1);
% preLable = zeros(1,dim);
% % lzDis = zeros(1,row-1);
% k = 9;
% lz = zeros(2,dim-1);

% EucPos = 0;
% EucNeg = 0;

% for i = 1:dim
%     trainInd = find(c.training(i)==1);
%     testInd = find(c.test(i)==1);
%     train = data{1}(trainInd);
%     test = data{1}(testInd);
% %   Tlable = pros(find(c.training(i)==1),col);
%     
% %    diff2 = c_con2-c_val(testInd,1);    
%     for j = 1:dim-1
% %       dif = train(j,:)-test;
% %       Euc(1,j) = norm(dif,2);
%         lz(1,j) = Distance(train{1}(j),test,c_val(trainInd(j,1),1),c_val(testInd,1));
%         lz(2,j) = trainInd(j,1);
%     end;
% %    [eucV eucInd] = sort(Euc);
% %    p = size(find(Tlable(eucInd(1,1:k))==1),1);
% %    n = size(find(Tlable(eucInd(1,1:k))==-1),1); 
%     [val ind] = sort(lz(1,:));
%     neighborInd = lz(2,ind(1,1:k));
%     neighbors = data{1}(neighborInd);

%   test_fuz_memship = zeros(3,2);
    
%     numerator1 = 0;
%     denominator1 = 0;
    numerator2 = 0;
    denominator2 = 0;
    
%     test_fuz_memship2 = zeros(6,dim);
%     calss_dec = zeros(3,2);

%     test_fuz_memship(1,2) = 'H';
%     test_fuz_memship(2,2) = 'E';
%     test_fuz_memship(3,2) = '-';
    
%     test_fuz_memship2(4,:) = 'H';
%     test_fuz_memship2(5,:) = 'E';
%     test_fuz_memship2(6,:) = '-';
    fuz_vals = zeros(3,1);
    
    for q = 1:3
%         for p = 1:k
%         numerator1 = numerator1 + init_fuz_memship(q,neighborInd(1,p))*(1/(val(1,p).^2));
%         denominator1 = denominator1 + (1/(val(1,p).^2));          
%         end;
%         test_fuz_memship(q,1) = numerator1/denominator1;     
%          
         numerator2 = init_fuz_memship(q,neighborInd)*(1./(val(1:k).^2))';
         denominator2 = sum(1./(val(1:k).^2));
         fuz_vals(q,1) =  numerator2/denominator2;
    end;
    
%     [~, minInd] = sort(test_fuz_memship2(1:3,1));
%     predic_lable = test_fuz_memship2(minInd(3,1)+3,1);  
%     in khat az ajzaye aslie barname pish az stage fusion ast 2 khate bala hastand.


% end;

% acc = ((sum(preLable==lable'))/row)*100;
% toc

% save('fKnnVars');
   