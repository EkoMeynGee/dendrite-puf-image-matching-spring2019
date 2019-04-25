Rmat = zeros(50,1);
parpool
fileName = "b9.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult9.mat RmatTemp