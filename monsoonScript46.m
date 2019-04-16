Rmat = zeros(50,1);
fileName = "b46.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult46.m Rmat