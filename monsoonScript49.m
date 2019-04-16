Rmat = zeros(50,1);
fileName = "b49.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult49.m Rmat