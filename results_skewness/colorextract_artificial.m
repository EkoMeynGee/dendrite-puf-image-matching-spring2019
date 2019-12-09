function skleton = colorextract_artificial(filename, mode)

if isstring(filename) || ischar(filename)
    RGB = imread(filename);
else
    RGB = filename;
end

if mode == 'r'
    RGB = imrotate(RGB, 180);
end
% imshow(RGB)

%convert frame from RGB to YCBCR colorspace
lab_he = rgb2lab(RGB);
[h, w, ~] = size(RGB);
% figure ,imshow(lab_he),title('L*A*B')

% ab = lab_he(:,:,:);
% ab = im2single(ab);
% pixel_labels = imsegkmeans(ab, 2, 'NumAttempts', 2);
% % figure, imshow(pixel_labels,[])
% 
% mask1 = pixel_labels==1;
% cluster1 = RGB .* uint8(mask1);
% % figure, imshow(cluster1)
% % title('Objects in Cluster 1');
% 
% mask2 = pixel_labels==2;
% cluster2 = RGB .* uint8(mask2);
% % figure, imshow(cluster2)
% % title('Objects in Cluster 2');
% 
% mask3 = pixel_labels==3;
% cluster3 = RGB .* uint8(mask3);
% % figure, imshow(cluster3)
% % title('Objects in Cluster 3');
% 
% a = max(max(cluster1));
% b = max(max(cluster2));
% c = max(max(cluster3));

% if (mean(a) > mean(b)) && (mean(a) > mean(c))
%     cluster = cluster1;
% elseif (mean(b) > mean(a)) && (mean(b) > mean(c))
%     cluster = cluster2;
% else
%     cluster = cluster3;
% end

lab_he = lab_he(:,:,2);
lab_he = adpmedian(lab_he,3);
% Image2= rgb2gray(lab_he);
% figure, imshow(Image2)
Image2 = imbinarize(lab_he, 12);
% imshow(Image2)
Image2 = bwareaopen(Image2, 40);

% circle_info_set = round(mean(hough_circle(Image2, .5, .1, 35, 35, 1),2));
% circle.centers(1,1) = w/2;
% circle.centers(1,2) = h/2;
% circle.radii = 36;
circle_info_set = round(mean(hough_circle(im2bw(rgb2gray(RGB)), .5, .1, 35, 35, 1),2));
circle.centers(1,1) = circle_info_set(2);
circle.centers(1,2) = circle_info_set(1);
circle.radii = circle_info_set(3);
% hold on, Image2 = viscircles(circle.centers, circle.radii, 'Color', 'w');
% Image2 = imfill(Image2, 'holes');
[xgrid, ygrid] = meshgrid(1:size(Image2,2), 1:size(Image2,1));
circlemask = sqrt((xgrid- circle.centers(1,1)).^2 + ...
    (ygrid- circle.centers(1,2)).^2) <= circle.radii + 2;
circlemask2 = sqrt((xgrid- circle.centers(1,1)).^2 + ...
    (ygrid- circle.centers(1,2)).^2) <= circle.radii + 1;
Image2 = logical(Image2 + circlemask);
%  figure, imshow(Image2)
Image2 = Image2 - circlemask2;
% figure, imshow(Image2)
Image2 = imdilate(Image2, strel('disk',1));

sk = bwmorph(Image2,'thin', inf);
% sk = bwmorph(Image2,'thin', 10);
skleton = bwmorph(sk, 'fill');
% figure, imshow(skleton)
% skleton = bwmorph(skleton,'fill');
% figure, imshow(skleton)
% skleton = bwmorph(skleton,'fill');
% figure, imshow(skleton)
% figure, imshow(skleton)
