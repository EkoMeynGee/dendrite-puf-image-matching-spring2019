Rmat = zeros(50,1);
fileName = "b18.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult18.m Rmat