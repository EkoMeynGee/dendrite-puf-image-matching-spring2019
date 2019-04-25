Rmat = zeros(50,1);
parpool
fileName = "b5.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult5.mat RmatTemp