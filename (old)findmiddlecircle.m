function [circle, background] = findmiddlecircle(filename)
% INPUT THE IMAGE AND DO NORMALIZATION AND SEGMATION to remove the part we
% don't want             Only work when it get the exactly same size image

% do normaliztion for image
OriginalImage = double(imread(filename));
[w,h,d] = size(OriginalImage);

% Image = rgb2gray(OriginalImage);

Image = mat2gray(OriginalImage);
% figure, imshow(Image,[])
Image = rgb2gray(Image);

% doing segmatation------------------------------------------------------
se = strel('disk',120);
background = imopen(Image,se);

Image2 = imtophat(Image,se);
% imshow(background),figure, imshow(Image2)

% [T, SM] = graythresh(Image2);.


% w = fspecial('sobel');
% h = w';
% gx = imfilter(Image2, w, 'replicate');
% gy = imfilter(Image2, h, 'replicate');
% grad = sqrt(gx.*gx + gy.*gy);
% grad  = grad/max(grad(:));
% figure, h = imhist(grad);
% Q = percentile2i(h, 0.999);
% makerImage = grad > Q;
% fp = Image2.*makerImage;
% figure, imshow(fp)
% 
% figure, hp = imhist(fp);
% hp(1) = 0;
% bar(hp)
% T = graythresh(hp);
Image2 = localthresh(Image2, ones(3), 30, 1.5, 'global');
% Image2 = imbinarize(Image2,T);
% figure, imshow(Image2)
% Image2 = bwareaopen(Image2,700);
%  figure, imshow(Image2)

% Identify the middle circle
cc = bwconncomp(Image2, 4);
cc.NumObjects
background = false(size(Image2));
%for i = 1:25
dentritedata = regionprops(cc,'basic');
dentriteArea = [dentritedata.Area];
[~,idx] = max(dentriteArea);
background(cc.PixelIdxList{idx}) = true;
% figure, imshow(background)
%background = false(size(Image2));
%end

skleton = bwmorph(background,'skel',inf);
%   figure, imshow(skleton)

c = regionprops(skleton, 'centroid', 'MajorAxisLength','MinorAxisLength');
centers = c.Centroid;
radii = mean([c.MajorAxisLength c.MinorAxisLength],2)/2;

circle.centers = centers;
circle.radii = radii;
%   imshow(skleton),viscircles(centers,1)

