Rmat = zeros(50,1);
fileName = "b15.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult15.m Rmat