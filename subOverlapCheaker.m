function logicalOut = subOverlapCheaker(x, y, pathType, image)

[ruleA, ruleB] = size(image);
logicalOut = false;

upPathType = mod(pathType+1, 8);
downPathType = mod(pathType-1, 8);

if (upPathType == 0)
    upPathType = 8;
end

if (downPathType == 0)
    downPathType = 8;
end

for index = 1:2
    if (index == 1)
        pathTypeTemp = upPathType;
    else
        pathTypeTemp = downPathType;
    end
    [xnext, ynext] = nextCoords(x, y, pathTypeTemp);
    [xnext2, ynext2] = nextCoords(xnext, ynext, pathTypeTemp); 
    if ((ynext2 >= ruleA) || (ynext2 <= 0)|| (xnext2 >= ruleB) ||...
            (xnext2 <= 0) || (image(ynext2, xnext2) == 1))
        logicalOut = true;
        break;
    end
    
    if ((ynext >= ruleA) || (ynext <= 0)|| (xnext >= ruleB) ||...
            (xnext <= 0) || (image(ynext, xnext) == 1))
        logicalOut = true;
        break;
    end
end



