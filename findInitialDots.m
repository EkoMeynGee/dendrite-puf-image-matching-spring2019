function TrueDotsSet = findInitialDots(skleton, iterTimes, rootinfo, exdotsSet)
%%Find the initial points of each branch of the skleton
%%The recursive function to find the points, iterTimes starts with 0

[het, len] = size(skleton);
[xgrid, ygrid] = meshgrid(1:len,1:het);

firstMask = (sqrt((xgrid - rootinfo.y).^2 + (ygrid - rootinfo.x).^2)...
    <= rootinfo.radius + iterTimes);

firstMask = -firstMask + 1;
skletonTemp = skleton .* firstMask;

secondMask = (sqrt((xgrid - rootinfo.y).^2 + (ygrid - rootinfo.x).^2)...
    <= rootinfo.radius + iterTimes + 1);

initialDotsImage = skletonTemp .* secondMask;
[dotsSetx, dotsSety] = find(initialDotsImage == 1);
dotsSet = [dotsSetx, dotsSety];


%%Solve the new dotsSet have two adjacent dots, only have the smaller one
numDots = size(dotsSet, 1);
tempdotsOg = dotsSet;
for index = 1:numDots
    tempDot = tempdotsOg(index,:);
    tempDotsSet = setdiff(dotsSet, tempDot, 'rows', 'stable');
    
    for index2 = 1:size(tempDotsSet,1)
        tempDot2 = tempDotsSet(index2,:);
        if ((tempDot(1) == tempDot2(1) || tempDot(1) == tempDot2(1)+1 || ...
                tempDot(1) == tempDot2(1)-1) && (tempDot(2) == tempDot2(2) || ...
                tempDot(2) == tempDot2(2)+1 || tempDot(2) == tempDot2(2)-1))
            
            r1 = sqrt((tempDot(1) - rootinfo.x)^2 + (tempDot(2) - rootinfo.y)^2);
            r2 = sqrt((tempDot2(1) - rootinfo.x)^2 + (tempDot2(2) - rootinfo.y)^2);
            
            if (r1 <= r2)
                dotsSet = setdiff(dotsSet, tempDot2, 'rows', 'stable');
            else
                dotsSet = setdiff(dotsSet, tempDot, 'rows', 'stable');
            end
            
            break;
        end
    end
end

%%Do comparison between the new dotsSet and previous one
numDots = size(dotsSet,1);
numexDots = size(exdotsSet,1);
tempSet = dotsSet;
for index = 1:numDots
    X = tempSet(index,1);
    Y = tempSet(index,2);
    for index2 = 1:numexDots
        exX = exdotsSet(index2,1);
        exY = exdotsSet(index2,2);
        if ((exX == X || exX == X + 1 ||  exX == X - 1)...
                && (exY == Y || exY == Y + 1 || exY == Y -1))
            dotsSet = setdiff(dotsSet,[X, Y], 'rows', 'stable');
            break;
        end
    end
end

if (iterTimes == 0)
    TrueDotsSet = dotsSet;
else
    TrueDotsSet = union(exdotsSet,dotsSet,'rows','stable');
end

if (iterTimes == 1)
    return;
else
    TrueDotsSet = findInitialDots(skleton, iterTimes + 1, rootinfo,...
        TrueDotsSet);
end




