Rmat = zeros(50,1);
fileName = "b37.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult37.m Rmat