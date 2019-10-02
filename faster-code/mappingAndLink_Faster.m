function [LinkedTree1, LinkedTree2, Distancematrix] = mappingAndLink_Faster(Tree1, Tree2,...
    param, FullTree1, FullTree2, factor, iter, Distancematrix_big)
%%First part according to tthe Distance Matrix to mapping and set up link
%%relationship with both two Tree structure each node

numT1 = numel(fieldnames(Tree1)); %%% Test nodes
numT2 = numel(fieldnames(Tree2)); %%% Data nodes

testField = fieldnames(Tree1);
dataField = fieldnames(Tree2);

if (numT1 > numT2)
    largesize = numT1;
elseif (numT1 < numT2)
    largesize = numT2;
else 
    largesize = numT1;
end

Distancematrix = inf(largesize);

if (iter == 0)
    %convert tree struct to tree_mat
    tree1_mat = struct2mat(FullTree1);
    tree2_mat = struct2mat(FullTree2);

    % [1: node.index,
    %  2: node.relativeLen,
    %  3: node.angle,
    %  4: distRoot,
    %  5: node.parentIndex,
    %  6: node.siblingIndex];

    for index = 1:numT1
        for index2 = 1:numT2
            t = .6;
            Distancematrix(index,index2) = t*DistanceScore_Fast(index, index2, tree1_mat, tree2_mat, param, factor) +...
                (1-t)*(abs(tree1_mat(index, 4) - tree2_mat(index2, 4)));
        end
    end
else
    for index = 1:numT1
        tt = str2double(testField{index}(2:end));
        for index2 = 1:numT2
            dd = str2double(dataField{index2}(2:end));
            Distancematrix(index,index2) = Distancematrix_big(tt,dd);
        end
    end
end



[~, mappingmatrix] = munkres(Distancematrix, numT1, numT2);

[testsetIndex, datasetIndex] = find(mappingmatrix == 1);

iterationTimes = length(testsetIndex);

%%Initialize two tree's linkTo
for index = 1:numT1 
    eval(['Tree1.' testField{index} '.linkTo = [];']);
end

for index = 1:numT2
    eval(['Tree2.' dataField{index} '.linkTo = [];']);
end

%%Start linking------------------------------------------------------------
for index = 1:iterationTimes
   eval(['Tree1.' testField{testsetIndex(index)} '.linkTo = ' strip(dataField{datasetIndex(index)},'n') ';']);
   eval(['Tree2.' dataField{datasetIndex(index)} '.linkTo = ' strip(testField{testsetIndex(index)}, 'n') ';']);
end

LinkedTree1 = Tree1;
LinkedTree2 = Tree2;


