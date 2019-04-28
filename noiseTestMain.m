function data = noiseTestMain(fileName,type)
refIMG = imread(fileName);
refIMG = im2double(refIMG);
if (type==1)
    noised_sample = 10;
    data = zeros(noised_sample, 1);
    
    parfor index = 1:noised_sample
        NImg = imageNoiseMaker(fileName,"salt & pepper",0.005*index + 0.045);
        denoise_image = denoiseHandle(NImg, "salt & pepper");
        matchedTreeindex = smallIdentification(denoise_image);
        data(index) = matchedTreeindex;
    end
elseif (type==2)
    noised_sample = 26;
    data = zeros(noised_sample, 1);
    
    parfor index = 1:noised_sample
        NImg = imageNoiseMaker(fileName,"gaussian",0.001*(index-1));
        denoise_image = denoiseHandle(NImg);
        matchedTreeindex = smallIdentification(denoise_image);
        data(index) = matchedTreeindex;
    end
    
end
end


function matchedTreeindex = smallIdentification(inputIMGE)
inputIMGE = (inputIMGE*-1) + 1;
[height, width] = size(inputIMGE);
rough_circle = hough_circle(inputIMGE,.5,0.1,33,37,1);

rough_circle = round(mean(rough_circle, 2));
circleCenter.x = rough_circle(1);
circleCenter.y = rough_circle(2);
circleCenter.radius = rough_circle(3);
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

end