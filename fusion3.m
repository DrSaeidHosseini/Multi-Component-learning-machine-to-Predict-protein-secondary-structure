
function [predLable] = fusion3(svm_preLab,class_fuz_val)

[~, minInd] = sort(class_fuz_val(1:3,1));

valWeight_knn = 0.411;
% valWeight_svm = 0.589;
ranNum = rand;

if (class_fuz_val(minInd(3,1)+3,1) == svm_preLab)
    predLable = class_fuz_val(minInd(3,1)+3,1);
else
    if (ranNum <= valWeight_knn)
    predLable = class_fuz_val(minInd(3,1)+3,1);
    else
    predLable = svm_preLab;
    end;
end;



