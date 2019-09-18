function rgb_img = false_magic(in, circleinfo)
% try convert the image from the binary to rgb

% in is the skeleton

in2 = bwperim(in, 4);
in3 = imdilate(in2, strel('disk',2));
imshow(in3)
% in = bwmorph(in3, 'thicken',1); @ a real useless function
 
in = im2uint8(in3);

% operation

[height, width] = size(in);
[xgrid, ygrid] = meshgrid(1:width, 1:height);
circle = sqrt((circleinfo.y - ygrid).^2 + (circleinfo.x...
    - xgrid).^2) <= circleinfo.radius+2;

circle2 = sqrt((circleinfo.y - ygrid).^2 + (circleinfo.x...
    - xgrid).^2) <= circleinfo.radius-6;


tempImg = zeros(height, width);
index_logical = (tempImg + circle - circle2) == 1;

temp1 = in;
% white [248, 248, 255]
temp1(index_logical) = 248;  % first layer white

% purple [209 95 238]
index1d = (temp1 == 255);

% outer layer [35-70, 65-90, 60-75]
%outer frame
temp1_d = randi([35,70], height, width,'uint8');
temp2_d = randi([65,90], height, width,'uint8');
temp3_d = randi([60,75], height, width,'uint8');

%dendrite layer
temp1_d(index1d) = randi([130, 170], sum(sum(index1d)),1);
temp2_d(index1d) = randi([75, 104], sum(sum(index1d)),1);
temp3_d(index1d) = randi([109, 150], sum(sum(index1d)),1);

%outer dual-ring circle
temp1_d(index_logical) = randi([242, 252], sum(sum(index_logical)),1);
temp2_d(index_logical) = randi([247, 255], sum(sum(index_logical)),1);
temp3_d(index_logical) = randi([240, 255], sum(sum(index_logical)),1);


%inner dual-ring cirlce
temp1_d(circle2) = randi([129, 167], sum(sum(circle2)),1);
temp2_d(circle2) = randi([163, 181], sum(sum(circle2)),1);
temp3_d(circle2) = randi([195, 230], sum(sum(circle2)),1);

rgb_img = im2uint8(cat(3,cat(3,temp1_d,temp2_d),temp3_d));
imshow(rgb_img)
