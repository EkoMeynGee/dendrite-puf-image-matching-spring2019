function [TreeStruct, new_result, cellnodes, distinfo, angleinfo] = graph_based_rdGen(image, circleInfo, varargin)
%%This function is differ than the original graph_based function, it should
%%be called when the image is just a skeleton, and can be easily get Tree
%%structure

%%% remove circle in center and find tree initial point
[height, width] = size(image);
radius = circleInfo.radius;
centery = circleInfo.x;
centerx = circleInfo.y;

% ADD 1st mask
initial_image = image;
[xgrid, ygrid] = meshgrid(1:width, 1:height);
mask = sqrt((xgrid-centery).^2 + (ygrid-centerx).^2) <= radius+1;
mask = (mask-1)*(-1);
initial_image = mask.*initial_image;

rootinfo.radius = radius;
rootinfo.x = centerx;
rootinfo.y = centery;
TrueDotsSet = findInitialDots(image, 1, rootinfo, []);

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
% viscircles([TrueDotsSet(:,2) TrueDotsSet(:,1)],ones(1,size(TrueDotsSet,1)) * 0.3);
parent.x = rootinfo.x;
parent.y = rootinfo.y;
parent.level = 1;

% The input is subnode for central node, parent and image,...
% the output is overthrough node based on the input nodes.
result = newNode_Search(points, initial_image, parent,[], [], 1, circleInfo);
% hold all;
% plot(result(:,2),result(:,1),'.','MarkerSize',20);
%%% prepare desired graph
new_result =zeros(size(result,1), 10);

for l =1 : size(result,1)
    % node[Rx(the distance between parent and child), Ry (same as
    % before), angle, type ,level, parentx, parenty, x, y, middle radius]
    % 11/19/18 modified angle to atan2 and make it as degree  Zaoyi
    new_result(l,:) = [result(l,1)-result(l,5) result(l,2)-result(l,6)...
        atan2(((result(l,6)-result(1,2))),(result(l,1)-result(1,5)))...
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

if (isempty(varargin))
    % Build TreeStructure %%%Modified Zaoyi
    [TreeStruct, distinfo, angleinfo] = buildTreeStrcut(cellnodes, new_result, rootinfo);
else
    distinfo = varargin{1};
    angleinfo = varargin{2};
    TreeStruct = buildTreeStrcut(cellnodes, new_result, rootinfo, distinfo, angleinfo);
    %%%
end
end