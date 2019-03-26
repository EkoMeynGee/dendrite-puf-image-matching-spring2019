function newimage = subTreeGen(Points , image, circle)
%%****** PathType detail goes here *********
%%------------1   2    3--------------------
%%------------8  null  4--------------------
%%------------7   6    5--------------------


numNodes = numel(fieldnames(Points));

SubProbMatrix1 = [0 0 0.05 0.9 0.05 0 0 0];
SubProbMatrix2 = [0 0.05 0.9 0.05 0 0 0 0];
SubProbMatrix3 = [0.05 0.9 0.05 0 0 0 0 0];
SubProbMatrix4 = [0.9 0.05 0 0 0 0 0 0.05];
SubProbMatrix5 = [0.05 0 0 0 0 0 0.05 0.9];
SubProbMatrix6 = [0 0 0 0 0 0.05 0.9 0.05];
SubProbMatrix7 = [0 0 0 0 0.05 0.9 0.05 0];
SubProbMatrix8 = [0 0 0 0.05 0.9 0.05 0 0];

for index = 1:numNodes
    Type = randNodeType();
    eval(['xTemp = Points.node' num2str(index) '.x;']);
    eval(['yTemp = Points.node' num2str(index) '.y;']);
    eval(['ProbMatrix = Points.node' num2str(index) '.Prob_Matrix;']);
    eval(['Points.node' num2str(index) '.nodeType = Type;']);
    image(yTemp, xTemp) = 1;
    
    %%Test
%     imshow(image)
    
    if Type == 1
        continue;
    elseif Type == 2
        SubPoints = [];
        numSubBranches = randi([2,3]);
        pathHistories = [];
        degreeHistories = [];
        junction = 1;
        trialCount = 0;
        trialCount2 = 0;
        while junction <= numSubBranches + 1
            rndDegreeChange = randi([30, 90]);
            degreeTemp = rad2deg(atan2((circle.y - yTemp),(xTemp - circle.x)));
            
            degreeChangeRdIndex = randi([1, 3]);
            if (ismember(degreeChangeRdIndex, degreeHistories))
                if (trialCount2 >= 40)
                    break;
                end
                trialCount2 = trialCount2 + 1;
                continue;
            end
            degreeHistories = [degreeHistories degreeChangeRdIndex];
            if degreeChangeRdIndex == 1
                degree = degreeTemp + rndDegreeChange;
            elseif degreeChangeRdIndex == 2
                degree = degreeTemp - rndDegreeChange;
            elseif degreeChangeRdIndex == 3
                degree = degreeTemp;
            end
            
            
            if degree > 180
                degree = degree - 360;
            elseif degree < -180
                degree = 360 + degree; 
            end
                
            
            if (degree < 45 && degree >=0)
                percent = degree / 45;
                Prob_Matrix = (1-percent) * SubProbMatrix1 + percent * SubProbMatrix2;
            elseif (degree < 90 && degree >= 45)
                percent = (degree - 45) / 45;
                Prob_Matrix = (1-percent) * SubProbMatrix2 + percent * SubProbMatrix3;
            elseif (degree < 135 && degree >= 90)
                percent = (degree - 90) / 45;
                Prob_Matrix = (1-percent) * SubProbMatrix3 + percent * SubProbMatrix4;
            elseif (degree <=180 && degree >= 135)
                percent = (degree - 135) / 45;
                Prob_Matrix = (1-percent) * SubProbMatrix4 + percent * SubProbMatrix5;
            elseif (degree < 0 && degree >= -45)
                percent = degree / -45;
                Prob_Matrix = (1-percent) * SubProbMatrix1 + percent * SubProbMatrix8;
            elseif (degree < -45 && degree >= -90)
                percent = (degree + 45) / -45;
                Prob_Matrix = (1-percent) * SubProbMatrix8 + percent * SubProbMatrix7;
            elseif (degree < -90 && degree >= -135)
                percent = (degree + 90) / -45;
                Prob_Matrix = (1-percent) * SubProbMatrix7 + percent * SubProbMatrix6;
            else
                percent = (degree + 135) / -45;
                Prob_Matrix = (1-percent) * SubProbMatrix6 + percent * SubProbMatrix5;
            end
            
            
            pathType = randPath_Choose(Prob_Matrix);
            
            if (ismember(pathType, pathHistories) )
                if (trialCount >= 40)
                    break;
                end
                trialCount = trialCount + 1;
                continue;
            end
            pathHistories = [pathHistories pathType];
            [xnext, ynext] = nextCoords(xTemp, yTemp, pathType);
            if checkFutureOverlap(xnext, ynext, pathType, image)
                numSubBranches = numSubBranches - 1;
                continue;
            end
            eval(['SubPoints.node' num2str(junction) '.x = xnext;']);
            eval(['SubPoints.node' num2str(junction) '.y = ynext;']);           
            eval(['SubPoints.node' num2str(junction)...
            '.Prob_Matrix = Prob_Matrix;']);
            junction = junction + 1;
        end
        
        if isempty(SubPoints)
            continue;
        else
            image = subTreeGen(SubPoints, image, circle);
        end
        
    elseif Type == 3
        pathType = randPath_Choose(ProbMatrix);
        [xnext, ynext] = nextCoords(xTemp, yTemp, pathType);
        if checkFutureOverlap(xnext, ynext, pathType, image)
            continue;
        end
        SubPoints.node1.x = xnext;
        SubPoints.node1.y = ynext;
        SubPoints.node1.Prob_Matrix = reAssign_Prob_Matrix...
            (pathType, ProbMatrix);
        image = subTreeGen(SubPoints, image, circle);
    end
end
newimage = image;




