
function [predLable] = fusion4(svm_preLab,class_fuz_val)

[~, minInd] = sort(class_fuz_val(1:3,1));

if (class_fuz_val(minInd(3,1)+3,1) == svm_preLab)
    predLable = class_fuz_val(minInd(3,1)+3,1);
else
    predLable = class_fuz_val(minInd(1,1)+3,1);
end;
