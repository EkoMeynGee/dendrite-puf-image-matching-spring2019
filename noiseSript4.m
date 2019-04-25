Rmat = zeros(50,1);
parpool
fileName = "b4.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult4.mat RmatTemp