function [filter] = filtering(svmFinalLab)

predLable = char(svmFinalLab');
predLable = strrep(predLable,'1','H');
predLable = strrep(predLable,'2','E');
predLable = strrep(predLable,'3','-');

data = struct2cell(load('protein_sequence.mat'));
data{1}(1:5) = [];

samsize = zeros(size(data{1},1)+1,1);

dim = size(samsize,1)-1;

samsize(1,1) = 1;

for i=1:dim 
    temp = data{1}{i};
    samsize(i+1,1) = size(temp,2);
end; 
    
for j=1:dim
    
    subStrInd = strfind(predLable(1,sum(samsize(1:j)):sum(samsize(1:j))+samsize(j+1)-1),'EHE');
    predLable(1,sum(samsize(1:j))+subStrInd) = 'E';    
    
    subStrInd = strfind(predLable(1,sum(samsize(1:j)):sum(samsize(1:j))+samsize(j+1)-1),'HEH');
    predLable(1,sum(samsize(1:j))+subStrInd) = 'H';    
    
    subStrInd = strfind(predLable(1,sum(samsize(1:j)):sum(samsize(1:j))+samsize(j+1)-1),'H-H');
    predLable(1,sum(samsize(1:j))+subStrInd) = 'H';
    
    subStrInd = strfind(predLable(1,sum(samsize(1:j)):sum(samsize(1:j))+samsize(j+1)-1),'E-E');
    predLable(1,sum(samsize(1:j))+subStrInd) = 'E';
    
    subStrInd = strfind(predLable(1,sum(samsize(1:j)):sum(samsize(1:j))+samsize(j+1)-1),'HEEH');
    predLable(1,sum(samsize(1:j))+subStrInd) = 'H';
    predLable(1,sum(samsize(1:j))+subStrInd+1) = 'H';   
    
end;

predLable = strrep(predLable,'H','1');
predLable = strrep(predLable,'E','2');
predLable = strrep(predLable,'-','3');
filter = double(predLable');
    
    


