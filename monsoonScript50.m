Rmat = zeros(50,1);
fileName = "b50.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult50.m Rmat