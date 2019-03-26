function [nodesSet,dotsSet] = newNode_Search(points, imageWoCircle, parent, dotsSet, nodesSet, init_flg)
%%This is newNode Search function to handle the always error inside of old
%%node_search function
%%The output will be a matrix with bunch of info
%%1. node.x | 2. node.y | 3. nodeType | 4. parentLevel | 5. parent.x | 6.
%%parent.y

numpoints = numel(fieldnames(points));
for index = 1:numpoints
    eval(['tempX = points.p' num2str(index) '.x;']);
    eval(['tempY = points.p' num2str(index) '.y;']);
    
    %---------------------Debug code----------------------------
    %     imshow(imageWoCircle)
%     viscircles([tempX tempY], 0.3);
    %-----------------------------------------------------------
    
    eval(['boxFramex = (points.p' num2str(index) '.x - 1) : (points.p' num2str(index) '.x + 1);']);
    eval(['boxFramey = (points.p' num2str(index) '.y - 1) : (points.p' num2str(index) '.y + 1);']);
    dotsSet = unique([dotsSet; tempX, tempY], 'rows' ,'stable');
    [Ys, Xs] = find((imageWoCircle(boxFramey, boxFramex) == 1));
    exactXs = Xs + tempX - 2;
    exactYs = Ys + tempY - 2;
    
    newdots = setdiff([exactXs, exactYs], dotsSet, 'rows', 'stable');
    
    numNewDots = size(newdots,1);
    %     type_counter = pointDetection(imageWoCircle(boxFramey, boxFramex));
    %     bifuration = [4, 6, 8];
    %     if (ismember(type_counter, bifuration) && numNewDots ~= 0 && numNewDots ~= 1)
    %         type_defined = numNewDots;
    %     end
    %
    %     if (type_counter == 4 && numNewDots == 1)
    %         type_defined = 1;
    %     end
    %
    %     if (type_counter == 2)
    %         type_defined = numNewDots;
    %     end
    
    dotsSet = unique([dotsSet; newdots], 'rows', 'stable');
    
    switch(numNewDots)
        case 0
            if (init_flg)
                continue
            end
            
            nodeType = 2;
            %--------DEBUG--------------
%             viscircles([tempX tempY], 1);
            %---------------------------
            nodesSet = [nodesSet; tempX, tempY,...
                nodeType, parent.level, parent.x, parent.y];
        case 1
            newpoints = struct;
            newpoints.p1.x = newdots(1);
            newpoints.p1.y = newdots(2);
            [nodesSet, dotsSet] = newNode_Search(newpoints, imageWoCircle,...
                parent, dotsSet, nodesSet, 0);
            
        otherwise
            nodeType = 1;
            %--------DEBUG--------------
%             viscircles([tempX tempY], 1);
            %---------------------------
            nodesSet = [nodesSet; tempX, tempY,...
                nodeType, parent.level, parent.x, parent.y];
            if numNewDots == 3
                indexS = middleOfThree(newdots);
                for index2 = 1:3
                    eval(['newpoints.p' num2str(index2) '.x = newdots(indexS(index2),1);']);
                    eval(['newpoints.p' num2str(index2) '.y = newdots(indexS(index2),2);']);
                end
            elseif (numNewDots == 2) && (init_flg ~= 1)
                newpoints = struct;
                newdots = go_old_way(imageWoCircle(boxFramey, boxFramex),...
                    tempX, tempY, setdiff(dotsSet,newdots,'rows', 'stable'), newdots, nodesSet);
                for index2 = 1:2
                    
                    eval(['newpoints.p' num2str(index2) '.x = newdots(index2,1);']);
                    eval(['newpoints.p' num2str(index2) '.y = newdots(index2,2);']);
                end
            else
                for index2 = 1:numNewDots
                    
                    eval(['newpoints.p' num2str(index2) '.x = newdots(index2,1);']);
                    eval(['newpoints.p' num2str(index2) '.y = newdots(index2,2);']);
                end
            end
            subParent.x = tempX;
            subParent.y = tempY;
            subParent.level = parent.level + 1;
            [nodesSet, dotsSet] = newNode_Search(newpoints, imageWoCircle,...
                subParent, dotsSet, nodesSet, 0);
            
    end
    
end
end


% function type_counter = pointDetection(littleFrame)
%
% %littleFrame = imageWoCircle(boxFramex, boxFramey);
% littleFrame_list = [littleFrame(1,1), littleFrame(1,2), littleFrame(1,3), littleFrame(2,3),...
%     littleFrame(3,3), littleFrame(3,2), littleFrame(3,1), littleFrame(2,1)];
% type_counter = 0;
%
% for index = 1:8
%     if (index == 1)
%         temp_a = littleFrame_list(8);
%     else
%         temp_a = littleFrame_list(index-1);
%     end
%
%     type_counter = type_counter + abs(littleFrame_list(index) - temp_a);
% end
%
% end
%

function index_sort = middleOfThree(newdots)
if (length(unique(newdots(:,1))) == 1) || (length(unique(newdots(:,2))) == 1)
    indexM = 2;
else
    for indexM = 1:3
        if (ismember(newdots(indexM,1),newdots(:,1)) && ismember(newdots(indexM,2),newdots(:,2)))
            break;
        end
    end
end
index =  setdiff([1,2,3],indexM, 'stable');
index_sort = [indexM, index(1), index(2)];
end

function dot = go_old_way(boxFrame, tempX, tempY, dotsSet, newdots, nodesSet)
boxFrame(2,2) = 0;
[Ys, Xs] = find((boxFrame == 1));
exactXs = Xs + tempX - 2;
exactYs = Ys + tempY - 2;
old_dot = intersect([exactXs, exactYs], dotsSet, 'rows', 'stable');
if (size(old_dot,1) ~= 1 )
    old_dot2 = intersect(old_dot,nodesSet(:,[1 2]),'rows','stable');
    if isempty(old_dot2)
        old_dot2 = old_dot;
    end
    old_dot = old_dot2;
end
diffX = -(old_dot(1,1) - tempX);
diffY = -(old_dot(1,2) - tempY);

firstdot = [tempX + diffX, tempY + diffY];
if (ismember(firstdot, newdots, 'rows'))
    dot = [firstdot; setdiff(newdots,firstdot,'rows', 'stable')];
else
    dot = newdots;
end
end
