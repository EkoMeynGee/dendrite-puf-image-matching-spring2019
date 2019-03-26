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