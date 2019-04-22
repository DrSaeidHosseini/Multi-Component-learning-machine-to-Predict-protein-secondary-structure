function [predLable] = fusion(test_fuz_memship2)

[~, minInd] = sort(test_fuz_memship2(1:3,1));
predLable = test_fuz_memship2(minInd(3,1)+3,1);  