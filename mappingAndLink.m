function [LinkedTree1, LinkedTree2] = mappingAndLink(Tree1, Tree2,...
    param, FullTree1, FullTree2)
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

for index = 1:numT1
    for index2 = 1:numT2
        eval(['Distancematrix(index,index2) = DistanceScore(Tree1.'...
            testField{index} ', Tree2.' dataField{index2} ', Tree1, Tree2, param, FullTree1, FullTree2);']);
    end
end

[minDist, mappingmatrix] = munkres(Distancematrix, numT1, numT2);

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

