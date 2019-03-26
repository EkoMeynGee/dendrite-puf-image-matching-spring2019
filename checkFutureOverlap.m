function logicalOut = checkFutureOverlap(xnext1, ynext1, pathType, image)
%%Main check function for avoiding overlap or future overlap


[ruleA, ruleB] = size(image);
circleCenter.x = ruleB / 2;
circleCenter.y = ruleA / 2;
circleCenter.radius = (ruleB / 2) - 20;
[xgrid, ygrid] = meshgrid(1:ruleB, 1:ruleA);

circle = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
    - xgrid).^2) <= circleCenter.radius;
circle2 = sqrt((circleCenter.y - ygrid).^2 + (circleCenter.x...
    - xgrid).^2) <= circleCenter.radius - 1;
image = image + circle - circle2;

logicalOut = false;

for index = 1:6
    if (index ~= 1)
        eval(['[xnext' num2str(index) ', ynext' num2str(index)...
            '] = nextCoords(xnext' num2str(index-1) ', ynext' num2str(index-1) ', pathType);']);
    end
    eval(['xtemp = xnext' num2str(index) ';']);
    eval(['ytemp = ynext' num2str(index) ';']);
    eval(['subChecker = subOverlapCheaker(xnext' num2str(index)...
        ', ynext' num2str(index) ', pathType, image);']);
    
    if ((ytemp >= ruleA) || (ytemp <= 0)|| (xtemp >= ruleB) ||...
            (xtemp <= 0) || (image(ytemp, xtemp) == 1))
        logicalOut = true;
        break;
    end
    
    if (subChecker)
        logicalOut = true;
        break;
    end
end


