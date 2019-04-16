Rmat = zeros(50,1);
fileName = "b10.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult10.m Rmat