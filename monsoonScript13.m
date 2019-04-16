Rmat = zeros(50,1);
fileName = "b13.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult13.m Rmat