function [maxmatchingRate, matchedTreeindex] = mappingMain(testingTree)

dataBase = load('artificial_TreeData.mat');

dataBase = dataBase.artificial_TreeData;

treeNum = numel(fieldnames(dataBase));


%%Put the OG image to be rotated image
% First test image has been rotated 180

% testingTree = dataBase.Tree2;

RmatriX = zeros(treeNum,1);
for index = 1: 1
    fprintf("checking puf REF%d...............\n",index);
    tic
    eval(['[ConsistentMatchTree, matchingRate] = mappingTest(testingTree,dataBase.Tree'...
        num2str(index) ',0.7,struct,struct,0,testingTree,dataBase.Tree' num2str(index) ',0);']);
    toc
    RmatriX(index) = matchingRate;
end

[maxmatchingRate, matchedTreeindex] = max(RmatriX);

% figure, bar(RmatriX)
% title 'barplot of matching rate'
% hold on
% plot(RmatriX)
% hold off