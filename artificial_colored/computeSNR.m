function snr = computeSNR(og_img, new_img, type)
% this function is designed to compute the image SNR
if type == 'r'
    og = rgb2gray(imread(og_img));
    nd = rgb2gray(imread(new_img));
elseif type == 'n' 
    og = rgb2gray(og_img);
    nd = rgb2gray(new_img);
else
    og = og_img;
    nd = new_img;
end

exp_snr = sum(sum(og.^2)) / sum(sum((og - nd).^2));
snr = 20 * log10(exp_snr);


