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
end

end