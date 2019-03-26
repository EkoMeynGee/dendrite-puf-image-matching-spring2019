function logicalResult = checkClosePoints(PointA, InitalSet, minDist)
%%Check if two points are too close, return true if too close

numPoints = size(InitalSet, 1);
logicalResult = false;

for index = 1:numPoints
    tempPoint.x = InitalSet(index, 1);
    tempPoint.y = InitalSet(index, 2);
    dist = sqrt((tempPoint.x - PointA.x).^2 + (tempPoint.y - PointA.y).^2);
    if (dist < minDist)
        logicalResult = true;
        break;
    end
end



