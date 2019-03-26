function [TreeStruct, new_result, cellnodes] =graph_based(image_file)
clear functions


% New modified colorextarct method    Modified date: 10/28/2018   Zaoyi
skleton = colorextract(image_file);


% New method find circle              Modified date: 10/14/2018  Zaoyi
circle = findmiddlecircle2(image_file);


%%% remove circle in center and find tree initial point
radius = floor((circle.radii));
centery= round(circle.centers(1,1));
centerx= round(circle.centers(1,2));

% ADD 1st mask
initial_image = skleton;
[xgrid, ygrid] = meshgrid(1:size(initial_image,2), 1:size(initial_image,1));
% figure, mesh(xgrid,ygrid)
mask = sqrt((xgrid-centery).^2 + (ygrid-centerx).^2) < radius;
mask = (mask-1)*(-1);
initial_image = mask.*initial_image;

rootinfo.radius = radius;
rootinfo.x = centerx;
rootinfo.y = centery;
TrueDotsSet = findInitialDots(skleton, 0, rootinfo, []);


for k =1 :size(TrueDotsSet,1)
    initialpoint(k).x = TrueDotsSet(k,1);
    initialpoint(k).y = TrueDotsSet(k,2);
end

% viscircles([TrueDotsSet(:,2) TrueDotsSet(:,1)],ones(1,size(TrueDotsSet,1)));
parent.x = centerx;
parent.y = centery;
parent.level = 0;

% The input is subnode for central node, parent and image,...
% the output is overthrough node based on the input nodes.
result=node_search(initialpoint,initial_image,parent,0);
% hold all;
% plot(result(:,2),result(:,1),'.','MarkerSize',20);
%%% prepare desired graph
[a,b] = size(result);
new_result =zeros(a, 10);

for l =1 : a
    % node[Rx(the distance between parent and child), Ry (same as
    % before), angle, type ,level, parentx, parenty, x, y, middle radius]
    % 11/19/18 modified angle to atan2 and make it as degree  Zaoyi 
    new_result(l,:) = [result(l,1)-result(l,5) result(l,2)-result(l,6)...
        rad2deg(atan2(((result(l,2)-result(1,6))),(result(l,1)-result(1,5))))...
        result(l,3) result(l,4) result(l,5) result(l,6) result(l,1) result(l,2) radius];
end
length_level = max(new_result(:,5)); % The highest depth
new_result =[new_result,zeros(a,1)];



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


%     [temp ia ib] = unique(new_result(:,8:9),'rows');
%     new_result = new_result(ia,:);

%     new_result = prune(new_result);

%     hold all;
%  plot(new_result(:,9),new_result(:,8),'.','MarkerSize',20);
%  samelevel_test   = new_result(find(new_result(:,5)==1),:);
% plot(samelevel_test(:,9),samelevel_test(:,8),'.','MarkerSize',20);
%%%
end