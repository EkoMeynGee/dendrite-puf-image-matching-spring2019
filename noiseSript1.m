Rmat = zeros(50,1);
parpool
fileName = "b1.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult1.mat RmatTemp