Rmat = zeros(50,1);
fileName = "b20.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult20.m Rmat