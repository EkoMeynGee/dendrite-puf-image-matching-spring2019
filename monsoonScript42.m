Rmat = zeros(50,1);
fileName = "b42.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult42.m Rmat