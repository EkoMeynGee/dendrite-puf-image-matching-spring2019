Rmat = zeros(50,1);
fileName = "b31.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult31.m Rmat