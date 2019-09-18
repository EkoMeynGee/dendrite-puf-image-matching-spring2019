snr_table = zeros([50,1]);
for i = 1:50
    eval(['fname1 = "c' num2str(i) '.png";']);
    eval(['fname2 = "c_other' num2str(i) '.png";']);
    snr_table(i) = computeSNR(fname1, fname2); 
end
snr_table


%% 
for i = 1:1
    eval(['fname1 = "c' num2str(i) '.png"']);
    img1 = imread(fname1);
    img2 = imread('c_other1.png');
    img2_no = imnoise(img2, 'gaussian',0,0.01);
    computeSNR(img1,img2_no,'n')
    figure, imshow(img1)
    figure, imshow(img2_no)
end