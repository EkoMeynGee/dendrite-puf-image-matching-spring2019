function [TreeStruct, new_result, cellnodes] = general_graph_based_rdGen(image, mode)
%%This is function is designed as general used for extract the tree info of
%%the brutal image. For here, it add a mode for 'black' panel and 'white' panel for
%%identification

if (mode == "white")
    mode = 0;
elseif (mode == "black")
    mode = 1;
else
    error("The mode input is not correct. It can be only 'white'/'black'.");
end


%%% find the middle circle from the image
[height, width] = size(image);
[centers, radii] = imfindcircle(image, [30 40]);
radius = radii;
centery = centers.x;
centerx = centers.y;

% ADD 1st mask
initial_image = image;
[xgrid, ygrid] = meshgrid(1:width, 1:height);
mask = sqrt((xgrid-centery).^2 + (ygrid-centerx).^2) <= radius;
mask = (mask-1)*(-1);
initial_image = mask.*initial_image;

rootinfo.radius = radius;
rootinfo.x = centerx;
rootinfo.y = centery;
if (mode == 0)
    flipedimage = (image - 1) * (-1);
else
    flipedimage = image;
end
TrueDotsSet = findInitialDots(flipedimage, 0, rootinfo, []);

%%Check initialDots existance and store

% index = 1;
for k =1 :size(TrueDotsSet,1)
%     if (initial_image(TrueDotsSet(k,1), TrueDotsSet(k,1)) ~= 1)
%         continue
%     end        
    eval(['points.p' num2str(k) '.x = TrueDotsSet(k,2);']);
    eval(['points.p' num2str(k) '.y = TrueDotsSet(k,1);']);
%     index = index + 1;
end

% imshow(image)
% viscircles([TrueDotsSet(:,2) TrueDotsSet(:,1)],zeros(1,size(TrueDotsSet,1)) * 0.3);
parent.x = rootinfo.x;
parent.y = rootinfo.y;
parent.level = 1;

% The input is subnode for central node, parent and image,...
% the output is overthrough node based on the input nodes.
if (mode == 0)
    initial_fliped_image = (initial_image - 1) * (-1);
else 
    initial_fliped_image = initial_image;
end

result = newNode_Search(points, initial_fliped_image, parent, [], [], 1);
% hold all;
% plot(result(:,2),result(:,1),'.','MarkerSize',20);
%%% prepare desired graph
new_result =zeros(size(result,1), 10);

for l =1 : size(result,1)
    % node[Rx(the distance between parent and child), Ry (same as
    % before), angle, type ,level, parentx, parenty, x, y, middle radius]
    % 11/19/18 modified angle to atan2 and make it as degree  Zaoyi
    new_result(l,:) = [result(l,1)-result(l,5) result(l,2)-result(l,6)...
        rad2deg(atan2(((result(l,2)-result(1,6))),(result(l,1)-result(1,5))))...
        result(l,3) result(l,4) result(l,5) result(l,6) result(l,1) result(l,2) radius];
end
length_level = max(new_result(:,5)); % The highest depth
new_result =[new_result,zeros(size(result,1),1)];



% Make the node set to have an id, which is based on angle
% Modified Zaoyi 11/25/2018
[newnew_result, index] = sort(new_result(:,3));
new_result = new_result(index,:);
for z=1:length_level      % To get the nodes with in the same level
    [samelevely,samelevelx] =  (find(new_result(:,5)==z));
    templevelmatrix = new_result(samelevely,3);
    [h,w] = size(templevelmatrix);
    Id = [1:h].';
    % Give them like a ID for every node, if they are in the same level, they have ID from [1, h].
    for ww=1:h
        new_result(samelevely(ww),10) = Id(ww);
    end
end


% Mark the node set to have ability to handle the children     %%%
% Modified Zaoyi 11/18/2018
[row, col] = size(new_result);
cellnodes = cell(row, col);
for r = 1:row
    for c = 1:col
        cellnodes{r,c} = new_result(r,c);
    end
end

count = 1;
for m = 1:row
    cellnodes{m, 12} = count;
    new_result(m, 12) = count;
    count = count + 1;
end


% Link children method, see specfic in the linkchildern method %% modified
% Zaoyi Chi
cellnodes = linkchildren(cellnodes, row, new_result);

for param = 1:row
    if (cellnodes{param,4} == 1)
        cellnodes{param,4} = 'bifurcation';
    elseif(cellnodes{param,4} == 2)
        cellnodes{param,4} = 'end';
    end
end

% Link siblings method, only for same parent and same level are siblings %
% modified Zaoyi Chi

cellnodes = linksibling(cellnodes, new_result);


% Build TreeStructure %%%Modified Zaoyi
TreeStruct = buildTreeStrcut(cellnodes, new_result);

%%%
end