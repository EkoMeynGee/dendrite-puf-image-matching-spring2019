function out = linkchildren(orcellnodes,maxindex, matrixnodes)

% load cellnodestest cellnodes

% if (isequal(orcellnodes, newcellnodes))

for index = 1: maxindex
    tempnodes = matrixnodes(index,:);
    childernset = matrixnodes(find(ismember(matrixnodes(:,[6 7]), tempnodes(:,[8 9]), 'rows')),:);
    
    [num junk] = size(childernset);
    tempset = zeros(1, num);
    %
    %     for t = 1:num
    %         tempset(1,t) = childernset(t, 12);
    %     end
    
    tempset(1:num) = childernset(:,12)';
    
    orcellnodes{index, 11} = tempset;
end

out = orcellnodes;
