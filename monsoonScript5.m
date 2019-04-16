Rmat = zeros(50,1);
fileName = "b5.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult5.m Rmat