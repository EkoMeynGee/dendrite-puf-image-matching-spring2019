function DendriteDicGen(numData)
%%This is the function used to generate a random denrite dictionary
%%Don't run this function unless it is necessary
%%This function will generate two dataset, one is the dataset with tons of
%%image in binary versoin. another one is the aritifical Tree dataset,
%%which is based on the artifical generated pics dictionary.
load('artificial_DendriteDic.mat');
for index = 1:numData
%     numBranch = randi([4, 12]);
%     [DendriteImage, circleInfo] = dendriteModelGenerator(numBranch);
%     eval(['artificial_DendriteDic.picRef' num2str(index) ' = DendriteImage;']);
    fprintf("%d\n",index);
    eval(['DendriteImage = artificial_DendriteDic.picRef' num2str(index) ';']);
    circleInfo.x = 400;
    circleInfo.y = 400;
    circleInfo.radius = 35;
    TreeStruct = graph_based_rdGen(DendriteImage, circleInfo);    
    eval(['artificial_TreeData.Tree' num2str(index) ' = TreeStruct;']);
end
%save artificial_DendriteDic artificial_DendriteDic
save artificial_TreeData artificial_TreeData