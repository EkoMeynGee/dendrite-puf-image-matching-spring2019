function [out, dist_scaled_info, angle_scaled_info] = buildTreeStrcut(input,matrix,rootinfo,varargin)
% Build a clear strcut of the tree
[a, b] = size(matrix);

% Link parent
newcol = cell(a,1);
for index = 1:a
    newcol{index,1} = find(ismember(matrix(:,[8 9]), matrix(index,[6 7]), 'rows'));
    
    %%Checker
    if (length(newcol{index,1}) > 1)
        error('somthing goes wrong')
    end
end

if (nargin == 5)
    angle_scaled_info = varargin{2};
    dist_scaled_info = varargin{1};
    dist_mean = dist_scaled_info(1);
    dist_var = dist_scaled_info(2);
    angle_mean = angle_scaled_info(1);
    angle_var = angle_scaled_info(2);
else
    angle_vec = [input{:,3}];
    dist_vec = sqrt(([input{:,1}]).^2 + ([input{:,2}]).^2);
    angle_mean = mean(angle_vec);
    dist_mean = mean(dist_vec);
    angle_var = var(angle_vec);
    dist_var = var(dist_vec);
    dist_scaled_info = [dist_mean, dist_var];
    angle_scaled_info = [angle_mean, angle_var];
end

for index = 1:a
    eval(['n' num2str(index) '.index = input{index,12};' ]);
    eval(['n' num2str(index) '.x = input{index,8};']);
    eval(['n' num2str(index) '.y = input{index,9};']);
    eval(['n' num2str(index) '.level = input{index,5};']);
    
    if (~isempty(varargin))
        eval(['n' num2str(index) '.angle = (input{index,3} - angle_mean)/angle_var;']);
        eval(['n' num2str(index) '.relativeLen = (sqrt((input{index,1})^2 + (input{index,2})^2) - dist_mean)/dist_var;']);
    else
        eval(['n' num2str(index) '.angle = (input{index,3} - 0)/1;']);
        eval(['n' num2str(index) '.relativeLen = (sqrt((input{index,1})^2 + (input{index,2})^2) - 0)/1;']);
    end 
    
    eval(['n' num2str(index) '.type = input{index,4};']);
    eval(['n' num2str(index) '.childIndex = [input{index,11}];']);
    eval(['n' num2str(index) '.levelIndex = input{index,10};']);
    eval(['n' num2str(index) '.DistanceSelf2ParentX = input{index,1};']);
    eval(['n' num2str(index) '.DistanceSelf2ParentY = input{index,2};']);   
    eval(['n' num2str(index) '.parentIndex = newcol{index,1};']);
    eval(['n' num2str(index) '.siblingIndex = input{index,13};']);
    eval(['n' num2str(index) '.distRoot = sqrt((input{index,8} - rootinfo.y)^2 + (input{index,9} - rootinfo.x)^2);']);
end

for index = 1:a
    eval(['Tree.n' num2str(index) ' = n' num2str(index) ';' ]);
end

out = Tree;


