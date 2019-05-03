function ratio = rt_checker(matchednode1, matchednode2, org_po, criterion, varargin)
% checker for the correct ratio of different feature mapping method

if isempty(varargin)
    % The default setting, the rotation is 180 degree
    diff = abs(matchednode1 - org_po);
    diff2 = abs(org_po - matchednode2);
    distance = diff - diff2;
    ratio = numel(find(sum(distance,2) < criterion)) / size(matchednode1,1);
end
   