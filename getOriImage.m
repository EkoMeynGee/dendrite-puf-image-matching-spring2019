function out = getOriImage(image_file)
% This main funciton is used to find the skelton of the image, and all
% following part will just use the image based on the skelton

skleton = colorextract(image_file);

out = skleton;

save imageB1sk out;
% imshow(skleton)



%---------------------Not be used so far----------------------------------
%-----------------------------------------------------------------------------------------
%--------------------------------------------------------------------------