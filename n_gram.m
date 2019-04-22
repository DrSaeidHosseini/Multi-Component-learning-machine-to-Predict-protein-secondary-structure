


function [subStrings, counts] = n_gram(fullString,N)
  if N == 1
    [subStrings,~, index] = unique(cellstr(fullString.'));  %.'# Simple case
  else
    nString = numel((fullString));
    index = hankel(1:(nString-N+1), (nString-N+1):nString);
    [subStrings, ~, index] = unique(cellstr(fullString(index)));
  end
  counts = accumarray(index, 1);
end


