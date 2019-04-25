Rmat = zeros(50,1);
parpool
fileName = "b6.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult6.mat RmatTemp