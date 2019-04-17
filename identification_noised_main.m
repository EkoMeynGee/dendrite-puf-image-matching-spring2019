function identification_noised_main(fileName, noiseName)
refIMG = imread(fileName);
refIMG = im2double(refIMG);
if noiseName == "salt & pepper"
    noised_sample = 1;
    data = zeros(noised_sample + 1, 1);
    
    for index = 1:noised_sample
        NImg = imageNoiseMaker(fileName,noiseName,0.005);
        %--------------------------------------------
        %                  imshow(NImg);
        img = [NImg,refIMG];
        figure, imshow(img)
        title(['image with pepper & salt noise', num2str(0.001*index)]);
        %--------------------------------------------
        
        denoise_image = denoiseHandle(NImg, noiseName);
%         imshow(denoise_image)
        fprintf("checking the noised image with noise %3f \n", 0.001*index);
        [maxmatchingRate, matchedTreeindex,~,iter_mat] = identification_noised(denoise_image, refIMG);
        data(index + 1,1) = maxmatchingRate;
        
    end
    
    figure, plot(data)
    title 'salt & pepper noise matching rate plot'
    
elseif noiseName == "gaussian"
    noised_sample = 30;
    data = zeros(noised_sample + 1, 1);
    
    for index = 0:noised_sample
        NImg = imageNoiseMaker(fileName,noiseName,0.001*index);
        %--------------------------------------------
%         imshow(NImg);
        img = [NImg,refIMG];
        figure, imshow(img)
%         title(['image with gaussian noise with standard deviation ', num2str(0.001*index)]);
        %--------------------------------------------
        
        denoise_image = denoiseHandle(NImg);
        fprintf("checking the noised image with noise %3f \n", 0.001*index);
        [maxmatchingRate, matchedTreeindex,~] = identification_noised(denoise_image, refIMG);
        data(index + 1,1) = maxmatchingRate;
        
    end
    
    figure, plot(data)
    title 'gaussian noise matching rate plot'
    
elseif noiseName == "motion"
    noised_sample = 25;
    data = zeros(noised_sample - 1, 1);
    
    for index = 2:noised_sample
        [NImg, LEN, THETA] = imageNoiseMaker(fileName, noiseName, index, 20);
        %--------------------------------------------
        %         imshow(NImg);
        %         title(['image with motion noise with ', num2str(0.001*index), 'pixels shifting and 20 degree rotation']);
        %--------------------------------------------
        
        denoise_image = denoiseHandle(NImg, noiseName, LEN, THETA);
        fprintf("checking the noised image with noise %d pixels shift and 20 degree \n",index);
        [maxmatchingRate, matchedTreeindex] = identification_noised(denoise_image);
        data(index - 1,1) = maxmatchingRate;
        
    end
    
    figure, plot(data)
    title 'motion blur noise matching rate plot'
end
end

function [maxmatchingRate, matchedTreeindex, exactCorrectNum,iter_mat] = identification_noised(inputIMGE, refIMG)
%PREPROCESS the initial image, the modeTYPE decide if the function need to
%handle the denoise the image and identificate the most possible one in reference set;

% inputIMGE = imread(fileName);
iter_mat = [];
matchedTreeindex = -1;
inputIMGE = im2double(inputIMGE);
refIMG = im2double(refIMG);
if (size(inputIMGE,3) == 3)
    inputIMGE = rgb2gray(inputIMGE);
end

if (size(refIMG,3) == 3)
    inputIMGE = rgb2gray(refIMGIMGE);
end
inputIMGE = (inputIMGE*-1) + 1;
refIMG = (refIMG*-1) + 1;

%---------OPTION1--------------------
% [height, width] = size(inputIMGE);
% rough_circle = hough_circle(inputIMGE,1,0.1,33,37,1);
% 
% rough_circle = round(mean(rough_circle, 2));
% circleCenter.x = rough_circle(1);
% circleCenter.y = rough_circle(2);
% circleCenter.radius = rough_circle(3);


% Check more accurate radius
% [xgrid, ygrid] = meshgrid(1:width, 1:height);
% tempradius = circleCenter.radius;
% for index = -3:3
%     circle = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
%         - xgrid).^2) <= tempradius + index;
%     circle2 = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
%         - xgrid).^2) <= tempradius + index -1;
%     circleDiff = circle - circle2;
%     [y, x] = find(circleDiff);
%     if (inputIMGE(y,x))
%         circleCenter.radius = tempradius + index;
%         break;
%     end
% end
% TreeStruct = graph_based_rdGen(inputIMGE, circleCenter);
% 
% [maxmatchingRate, matchedTreeindex] = mappingMain(TreeStruct);
% if (maxmatchingRate < 0.2)
%     fprintf("The maxmachingRate is %d, which is too low. There is no PUF MATCHED!!", maxmatchingRate);
% else
%     fprintf("This testing PUF DENDRITE is matched to IMAGE b%d in reference!!! \n The mathcing Rate is %d!!!!!",...
%         matchedTreeindex, maxmatchingRate);
% end
% end
%----------------END OPTION 1-----------

%-----OPTION 2----------------------
[maxmatchingRate, exactCorrectNum,iter_mat] = algfixTesting(inputIMGE, refIMG);
end
%-----END OPTION 2-------------------------





function [NImg, LEN, THETA] = imageNoiseMaker(fileName,noiseName,varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

I = imread(fileName);
I = im2double(I);
LEN = 0; THETA = 0;
if (noiseName == "gaussian")
    NImg = imnoise(I, 'gaussian', 0, varargin{1});
elseif (noiseName == "salt & pepper")
    NImg = imnoise(I, 'salt & pepper', varargin{1});
elseif (noiseName == "motion")
    LEN = varargin{1};
    THETA = varargin{2};
    PSF = fspecial('motion', LEN, THETA);
    NImg = imfilter(I, PSF, 'conv', 'circular');
end
end

function denoise_image = denoiseHandle(noised_image, varargin)

if isempty(varargin)
    denoise_image = wiener2(noised_image);
    denoise_image = imbinarize(denoise_image);
    denoise_image = bwareaopen(denoise_image, 400);
elseif varargin{1} == "salt & pepper"
    format = fspecial('average', 5);
    denoise_image = filter2(format, noised_image);
    denoise_image = imbinarize(denoise_image);
    denoise_image = bwareaopen(denoise_image, 400);
    denoise_image = -denoise_image + 1;
    denoise_image = bwmorph(denoise_image,'thin',inf);
    denoise_image = -denoise_image + 1;
elseif varargin{1} == "motion"
    LEN = varargin{2};
    THETA = varargin{3};
    PSF = fspecial('motion', LEN, THETA);
    NSR = 0;
    denoise_image = deconvwnr(noised_image, PSF, NSR);
    denoise_image = imbinarize(denoise_image);
end

end

