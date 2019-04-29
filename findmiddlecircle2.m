function [circle, background] = findmiddlecircle2(filename)
% INPUT THE IMAGE AND DO NORMALIZATION AND SEGMATION to remove the part we
% don't want             Only work when it get rotated
RGB = imread(filename);
% imshow(RGB)

%convert frame from RGB to YCBCR colorspace
dd1=(RGB(:,:,1)<=255 & RGB(:,:,1)>=240 & RGB(:,:,2)<=255 & RGB(:,:,2)>=240 & RGB(:,:,3)<=255 & RGB(:,:,3)>=240);

[a, b] = size(dd1);

 img = zeros(a,b);

% image(cat(3,dd1,img,img));

img2 = cat(3,dd1,img,img);
% imshow(img2);


Image2= rgb2gray(img2);
Image2 = imbinarize(Image2);
Image2(1:80,:) = 0;
Image2(end-80:end,:) = 0;
Image2(:,1:140) = 0;
Image2(:,end-140:end) = 0;
% imshow(Image2);

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
% figure, imshow(skleton)

c = regionprops(skleton, 'centroid', 'MajorAxisLength','MinorAxisLength');
centers = c.Centroid;
radii = mean([c.MajorAxisLength c.MinorAxisLength],2)/2;

circle.centers = centers;
circle.radii = radii;

