Rmat = zeros(50,1);
fileName = "b44.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult44.m Rmat