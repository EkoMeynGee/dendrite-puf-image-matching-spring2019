function [xnext, ynext] = nextCoords(xTemp, yTemp, pathType)

if pathType == 1
    xnext = xTemp - 1;
    ynext = yTemp - 1;
elseif pathType == 2
    xnext = xTemp;
    ynext = yTemp - 1;
elseif pathType == 3
    xnext = xTemp + 1;
    ynext = yTemp - 1;
elseif pathType == 4
    xnext = xTemp + 1;
    ynext = yTemp;
elseif pathType == 5
    xnext = xTemp + 1;
    ynext = yTemp + 1;
elseif pathType == 6
    xnext = xTemp;
    ynext = yTemp + 1;
elseif pathType == 7
    xnext = xTemp - 1;
    ynext = yTemp + 1;
elseif pathType == 8
    xnext = xTemp - 1;
    ynext = yTemp;
end
