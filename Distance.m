
function [lz] = Distance(s1,s2,c_val1,c_val2)
    
    concat1 = strcat(s1,s2);
    concat2 = strcat(s2,s1);
    c_con1 = Ex_His(char(concat1));
    c_con2 = Ex_His(char(concat2));
    diff1 = c_con1-c_val1;
    diff2 = c_con2-c_val2;
    strmatch = size(intersect(s1,s2),2);
    unistr1 = size(unique(s1),2);
    unistr2 = size(unique(s2),2);
    strdismtc = (max(unistr1,unistr2)-strmatch);
    
    [subStrings1,~] = n_gram(s1,10);
    [subStrings2,~] = n_gram(s2,10);
    sharedStrings = intersect(subStrings1,subStrings2);
    nShared = numel(sharedStrings);

    lz = ((max(diff1,diff2)*(1+strdismtc/(strmatch+1)))/max(c_val1,c_val2))*1/(nShared+1);
     
%    lz = (max(c_val1,c_val2)/(1+max(diff1,diff2)))*(strmatch/(1+strdismtc))*(1+ nShared);

% lz = (max(c_val1,c_val2)*(1+strmatch/(1+strdismtc)))/(1+max(diff1,diff2));
% in formulaye sevomi ba dovomi farghi nadare. yani n-gram tasiri dar sehat
% ba tedade data ye sabete 61 tai nadasht.



 
    
