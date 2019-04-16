Rmat = zeros(50,1);
fileName = "b11.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult11.m Rmat