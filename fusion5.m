function [predLable] = fusion5(svm_preLab,class_fuz_val)

[~, minInd] = sort(class_fuz_val(1:3,1));

valWeight_knn = 0.3;
% valWeight_svm = 0.589;
ranNum = rand;

if (class_fuz_val(minInd(3,1)+3,1) == svm_preLab)
    predLable = class_fuz_val(minInd(3,1)+3,1);
else
    if (ranNum <= valWeight_knn)
    predLable = class_fuz_val(minInd(1,1)+3,1);
    else
    predLable = class_fuz_val(minInd(2,1)+3,1);
    end;
end;



