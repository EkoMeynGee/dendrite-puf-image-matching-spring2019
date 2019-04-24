function [maxmatchingRate, matchedTreeindex,RmatriX] = mappingMain(testingTree, varargin)

if (~isempty(varargin))
    distinfo = varargin{1};
    angleinfo = varargin{2};
end


dataBase = load('artificial_TreeData.mat');
dataBase = dataBase.artificial_TreeData;
treeNum = 30;
% treeNum = numel(fieldnames(dataBase));

%%Put the OG image to be rotated image
% First test image has been rotated 180

% testingTree = dataBase.Tree2;

RmatriX = zeros(treeNum,1);
testingTree = dynamicChangeTreeStruct(testingTree, distinfo, angleinfo);
for index = 1:treeNum
    fprintf("checking puf REF%d...............\n",index);
    if (~isempty(varargin))
        eval(['newTreeStruct = dynamicChangeTreeStruct(dataBase.Tree' num2str(index) ', distinfo, angleinfo);']);
    else
        eval(['newTreeStruct = dataBase.Tree' num2str(index) ';']);
    end
    tic
    [ConsistentMatchTree, matchingRate] = mappingTest(testingTree,newTreeStruct,0.7,struct,struct,0,...
        testingTree,newTreeStruct,0,.9);
    toc
    RmatriX(index) = matchingRate;
end


[maxmatchingRate, matchedTreeindex] = max(RmatriX);

% figure, bar(RmatriX)
% title 'barplot of matching rate'
% hold on
% plot(RmatriX)
% hold off

end


function newTreeStruct = dynamicChangeTreeStruct(TreeStruct, distinfo, angleinfo)


nodeNum = numel(fieldnames(TreeStruct));
dist_mean = distinfo(1);
dist_var = distinfo(2);
angle_mean = angleinfo(1);
angle_var = angleinfo(2);

for index = 1:nodeNum
    eval(['angleTemp = TreeStruct.n' num2str(index) '.angle;']);
    eval(['distTemp = TreeStruct.n' num2str(index) '.relativeLen;']);
    eval(['TreeStruct.n' num2str(index) '.angle = (angleTemp - angle_mean)/angle_var;']);
    eval(['TreeStruct.n' num2str(index) '.relativeLen = (distTemp - dist_mean)/dist_var;']);
end

newTreeStruct = TreeStruct;

end
