Rmat = zeros(50,1);
fileName = "b25.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult25.m Rmat