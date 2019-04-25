Rmat = zeros(50,1);
parpool
fileName = "b7.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult7.mat RmatTemp