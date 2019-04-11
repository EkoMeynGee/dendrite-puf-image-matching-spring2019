function Rmat = identification(fileName, varargin)
%PREPROCESS the initial image, the modeTYPE decide if the function need to
%handle the denoise the image and identificate the most possible one in reference set;

inputIMGE = imread(fileName);
inputIMGE = im2double(inputIMGE);
if (size(inputIMGE,3) == 3)
    inputIMGE = rgb2gray(inputIMGE);
end
inputIMGE = (inputIMGE*-1) + 1;
[height, width] = size(inputIMGE);
rough_circle = hough_circle(inputIMGE,.5,0.1,33,37,1);

rough_circle = round(mean(rough_circle, 2));
circleCenter.x = rough_circle(1);
circleCenter.y = rough_circle(2);
circleCenter.radius = rough_circle(3);

%DENOISE PROCESS IF IT IS NECESSARY
if (~isempty(varargin))
    if (varargin{1} == "denoise")
        inputIMGE = denoiseHandle(inputIMGE);
    end
end

% Check more accurate radius
[xgrid, ygrid] = meshgrid(1:width, 1:height);
tempradius = circleCenter.radius;
for index = -3:3
    circle = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
        - xgrid).^2) <= tempradius + index;
    circle2 = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
        - xgrid).^2) <= tempradius + index -1;
    circleDiff = circle - circle2;
    [y, x] = find(circleDiff);
    temptotal = numel(y);
    if (sum(inputIMGE(y,x))/temptotal > .93)
        circleCenter.radius = tempradius + index;
        disp("succuessfully find the more accurate radius")
        break;
    end
    
    if (index == 3)
        circleCenter.radius = tempradius + .5;
    end
end


[TreeStruct, ~, ~, distinfo, angleinfo] = graph_based_rdGen(inputIMGE, circleCenter);

[maxmatchingRate, matchedTreeindex, Rmat] = mappingMain(TreeStruct,distinfo,angleinfo);
if (maxmatchingRate < 0.2)
    fprintf("The maxmachingRate is %d, which is too low. There is no PUF MATCHED!! \n", maxmatchingRate);
else
    fprintf("This testing PUF DENDRITE is matched to IMAGE b%d in reference!!! \n The mathcing Rate is %d!!!!! \n",...
        matchedTreeindex, maxmatchingRate);
end

fprintf("-----------------------------------------------------\n\n\n\n\n\n");

