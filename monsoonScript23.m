Rmat = zeros(50,1);
fileName = "b23.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult23.m Rmat