Rmat = zeros(50,1);
parpool
fileName = "b8.tif";
RmatTemp = noiseTestMain(fileName,1);
save noiseResult8.mat RmatTemp