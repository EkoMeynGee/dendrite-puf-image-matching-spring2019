%%General method by using Feature point extraction
%%% Feature point method
% 
% I1 = imread('b1.png');
% 
% I1 = rgb2gray(I1);
% 
% I2 = rgb2gray(imread('b2.png'));

%% Harris
I1 = rgb2gray(imread('b1.png'));
I2 = rgb2gray(imread('b1rotat.png'));

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure; 
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
title(ax, 'Harris Features point matches');
legend(ax,'matched points 1','matched points 2');


%% SURF
I1 = rgb2gray(imread('b1.png'));
I2 = rgb2gray(imread('b1rotat.png'));

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure; 
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
title(ax, 'SURF Features point matches');
legend(ax,'matched points 1','matched points 2');


%% BRISK

I1 = rgb2gray(imread('b1.png'));
I2 = rgb2gray(imread('b1rotat.png'));

points1 = detectBRISKFeatures(I1);
points2 = detectBRISKFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure; 
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
title(ax, 'BRISK Features point matches');
legend(ax,'matched points 1','matched points 2');

%% FAST

I1 = rgb2gray(imread('b1.png'));
I2 = rgb2gray(imread('b1rotat.png'));

points1 = detectFASTFeatures(I1);
points2 = detectFASTFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure; 
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
title(ax, 'BRISK Features point matches');
legend(ax,'matched points 1','matched points 2');

%% Tree structure based feature matching
sk = colorextract('b1.png');
figure, imshow(sk)

