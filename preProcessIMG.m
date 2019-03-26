function [outputArg1,outputArg2] = preProcessIMG(testIMG_fileName, mode)
%This function will be the main testFuction, it needs to be called when get
%a brutal image, here is the function, which is designed for image
%processing

testIMG = testimread(testIMG_fileName);
testIMG = imresize(testIMG, [800 800]);

%%This part of code is leave for dealing with different kind of image noise
%%DENOISING




%--------------------------------------------------------------------------


end

