function [DendriteImage, circleCenter] = dendriteModelGenerator(numBranch)

%%This part put a circle into the center of image
image = zeros(925,772);
[height, width] = size(image);
circleCenter.x = width/2;
circleCenter.y = height/2;
circleCenter.radius = 35;

[xgrid, ygrid] = meshgrid(1:width, 1:height);
circle = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
    - xgrid).^2) <= circleCenter.radius;

circle2 = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
    - xgrid).^2) <= circleCenter.radius - 1;

circle3 = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
    - xgrid).^2) <= circleCenter.radius - 10;

image = image + circle - circle2 + circle3;
%%This part randomly find the initial starts points on the circle
[yCoordin, xCoordin] = find(image == 1);
numDots = numel(yCoordin);

randIndexSet = [];
randInitalSet = zeros(numBranch,2);
index = 1;
while(index ~= numBranch + 1)
    randindexTemp = randi([1, numDots]);
    tempDot.x = xCoordin(randindexTemp);
    tempDot.y = yCoordin(randindexTemp);
    if (ismember(randindexTemp,randIndexSet) || checkClosePoints...
            (tempDot, randInitalSet, 12))
        continue;
    end
    randIndexSet = [randIndexSet randindexTemp];
    randInitalSet(index,1) = tempDot.x;
    randInitalSet(index,2) = tempDot.y;
    index = index + 1;
end

%Debug
% imshow(image)
% viscircles(randInitalSet,ones(numBranch,1));


InitalProbMatrix1 = [0 0 0.05 0.9 0.05 0 0 0];
InitalProbMatrix2 = [0 0.05 0.9 0.05 0 0 0 0];
InitalProbMatrix3 = [0.05 0.9 0.05 0 0 0 0 0];
InitalProbMatrix4 = [0.9 0.05 0 0 0 0 0 0.05];
InitalProbMatrix5 = [0.05 0 0 0 0 0 0.05 0.9];
InitalProbMatrix6 = [0 0 0 0 0 0.05 0.9 0.05];
InitalProbMatrix7 = [0 0 0 0 0.05 0.9 0.05 0];
InitalProbMatrix8 = [0 0 0 0.05 0.9 0.05 0 0];

%%Calculate degree and assign Probility matrix
for index = 1:numBranch
    eval(['Points.node' num2str(index) '.x = randInitalSet(index,1);']);
    eval(['Points.node' num2str(index) '.y = randInitalSet(index,2);']);
    eval(['Points.node' num2str(index)...
        '.degree = rad2deg(atan2((circleCenter.y - randInitalSet(index,2)),(randInitalSet(index,1) - circleCenter.x)));']);
    eval(['degreeTemp = Points.node' num2str(index) '.degree;']);
    if (degreeTemp < 45 && degreeTemp >=0)
        percent = degreeTemp / 45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix1 + percent * InitalProbMatrix2);']);
    elseif (degreeTemp <90 && degreeTemp >= 45)
        percent = (degreeTemp - 45) / 45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix2 + percent * InitalProbMatrix3);']);
    elseif (degreeTemp <135 && degreeTemp >= 90)
        percent = (degreeTemp - 90) / 45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix3 + percent * InitalProbMatrix4);']);
    elseif (degreeTemp <=180 && degreeTemp >= 135)
        percent = (degreeTemp - 135) / 45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix4 + percent * InitalProbMatrix5);']);
    elseif (degreeTemp < 0 && degreeTemp >= -45)
        percent = (degreeTemp) / -45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix1 + percent * InitalProbMatrix8);']);
    elseif (degreeTemp < -45 && degreeTemp >= -90)
        percent = (degreeTemp + 45) / -45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix8 + percent * InitalProbMatrix7);']);
    elseif (degreeTemp < -90 && degreeTemp >= -135)
        percent = (degreeTemp + 90) / -45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix7 + percent * InitalProbMatrix6);']);
    else
        percent = (degreeTemp + 135) / -45;
        eval(['Points.node' num2str(index)...
            '.Prob_Matrix = ((1-percent) * InitalProbMatrix6 + percent * InitalProbMatrix5);']);
    end
end


DendriteImage = subTreeGen(Points, image, circleCenter);
DendriteImage = logical(DendriteImage);
DendriteImage = bwskel(DendriteImage);
% 
% DendriteImage = bwmorph(DendriteImage,'thin',inf);
% DendriteImage = bwmorph(DendriteImage,'fill');
% DendriteImage = bwmorph(DendriteImage,'thin',inf);
% imshow(DendriteImage);


