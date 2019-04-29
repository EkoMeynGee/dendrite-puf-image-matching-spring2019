function skleton = colorextract(filename)

RGB = imread(filename);
% imshow(RGB)

%convert frame from RGB to YCBCR colorspace
lab_he = rgb2lab(RGB);
% figure ,imshow(lab_he),title('L*A*B')

ab = lab_he(:,:,2:3);
ab = im2single(ab);
pixel_labels = imsegkmeans(ab, 3, 'NumAttempts', 3);
% figure, imshow(pixel_labels,[])

mask1 = pixel_labels==1;
cluster1 = RGB .* uint8(mask1);
%     figure, imshow(cluster1)
%   title('Objects in Cluster 1');

mask2 = pixel_labels==2;
cluster2 = RGB .* uint8(mask2);
%     figure, imshow(cluster2)
%  title('Objects in Cluster 2');

mask3 = pixel_labels==3;
cluster3 = RGB .* uint8(mask3);
%      figure, imshow(cluster3)
%   title('Objects in Cluster 3');

a = max(max(cluster1));
b = max(max(cluster2));
c = max(max(cluster3));

if ( a(:,:,2) <= b(:,:,2) && a(:,:,2) <= c(:,:,2) )
    cluster = cluster1;
elseif( b(:,:,2) <= a(:,:,2) && b(:,:,2) <= c(:,:,2) )
    cluster = cluster2;
elseif( c(:,:,2) <= a(:,:,2) && c(:,:,2) <= b(:,:,2) )
    cluster = cluster3;
end

Image2= rgb2gray(cluster);
% figure, imshow(Image2)
Image2 = imbinarize(Image2,0.35);
% imshow(Image2)

circle = findmiddlecircle2(filename);
% hold on, Image2 = viscircles(circle.centers, circle.radii, 'Color', 'w');
% Image2 = imfill(Image2, 'holes');
[xgrid, ygrid] = meshgrid(1:size(Image2,2), 1:size(Image2,1));
circlemask = sqrt((xgrid- circle.centers(1,1)).^2 + ...
    (ygrid- circle.centers(1,2)).^2) <= circle.radii;
circlemask2 = sqrt((xgrid- circle.centers(1,1)).^2 + ...
    (ygrid- circle.centers(1,2)).^2) <= circle.radii-1;
Image2 = Image2 + circlemask;
%  figure, imshow(Image2)
Image2 = bwareaopen(Image2, 700);
% figure, imshow(Image2)


cc = bwconncomp(Image2, 4);
background = false(size(Image2));
% hold on, cc = viscircles(circle.centers, circle.radii, 'Color', 'w');
% cc = imfill(cc, 'holes'); figure, imshow(cc)

dentritedata = regionprops(cc,'basic');
dentriteArea = [dentritedata.Area];
[~,idx] = max(dentriteArea);
background(cc.PixelIdxList{idx}) = true;


skleton = bwmorph(background,'thin',inf);
% figure, imshow(skleton)
skleton = bwmorph(skleton,'fill');
% figure, imshow(skleton)
skleton = bwmorph(skleton,'fill');
% figure, imshow(skleton)
skleton = logical(skleton | circlemask) - circlemask2;
% figure, imshow(skleton)
