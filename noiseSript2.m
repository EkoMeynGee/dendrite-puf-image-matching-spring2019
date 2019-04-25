Rmat = zeros(50,1);
parpool
fileName = "b2.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult2.mat RmatTemp