Rmat = zeros(50,1);
fileName = "b43.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult43.m Rmat