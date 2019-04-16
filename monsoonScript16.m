Rmat = zeros(50,1);
fileName = "b16.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult16.m Rmat