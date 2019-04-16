Rmat = zeros(50,1);
fileName = "b24.tif";
RmatTemp = identification(fileName);
Rmat(:) = RmatTemp;
save impuf50x50compareResult24.m Rmat