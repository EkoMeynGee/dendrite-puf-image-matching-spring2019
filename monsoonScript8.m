Rmat = zeros(50,1);
fileName = "b8.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult8.m Rmat