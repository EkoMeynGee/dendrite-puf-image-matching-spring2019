Rmat = zeros(50,1);
parpool
fileName = "b3.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult3.mat RmatTemp