function cellnodes = linksibling(cellnodes, matrixnodes)
%%This function is appied to link the sibling index method
%%Only for the parent is the same

[iterationTimes, b] = size(cellnodes);
temp = cell(iterationTimes,1);

for index = 1:iterationTimes
    parent = matrixnodes(index,[6 7]);
    level = matrixnodes(index,5);
    siblingset = find(ismember(matrixnodes(:,[6 7]), parent,'rows') & ...
        ismember(matrixnodes(:,5), level,'rows'))';
    temp{index,1} = setdiff(siblingset,index);
end

cellnodes = [cellnodes, temp];