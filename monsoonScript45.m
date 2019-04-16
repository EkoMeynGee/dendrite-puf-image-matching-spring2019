Rmat = zeros(50,1);
fileName = "b45.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult45.m Rmat