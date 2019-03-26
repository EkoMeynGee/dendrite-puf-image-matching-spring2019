function out = buildTreeStrcut(input,matrix,rootinfo)
% Build a clear strcut of the tree
[a, b] = size(matrix);

% Link parent
newcol = cell(a,1);
for index = 1:a
    newcol{index,1} = find(ismember(matrix(:,[8 9]), matrix(index,[6 7]), 'rows'));
    if (length(newcol{index,1}) > 1)
        error('somthing goes wrong')
    end
end


for index = 1:a
    eval(['n' num2str(index) '.index = input{index,12};' ]);
    eval(['n' num2str(index) '.x = input{index,8};']);
    eval(['n' num2str(index) '.y = input{index,9};']);
    eval(['n' num2str(index) '.level = input{index,5};']);
    eval(['n' num2str(index) '.angle = input{index,3};']);
    eval(['n' num2str(index) '.type = input{index,4};']);
    eval(['n' num2str(index) '.childIndex = [input{index,11}];']);
    eval(['n' num2str(index) '.levelIndex = input{index,10};']);
    eval(['n' num2str(index) '.DistanceSelf2ParentX = input{index,1};']);
    eval(['n' num2str(index) '.DistanceSelf2ParentY = input{index,2};']);
    eval(['n' num2str(index) '.relativeLen = sqrt((input{index,1})^2 + (input{index,2})^2);']);
    eval(['n' num2str(index) '.parentIndex = newcol{index,1};']);
    eval(['n' num2str(index) '.siblingIndex = input{index,13};']);
    eval(['n' num2str(index) '.distRoot = sqrt((input{index,8} - rootinfo.x)^2 + (input{index,9} - rootinfo.y)^2);']);
end

for index = 1:a
    eval(['Tree.n' num2str(index) ' = n' num2str(index) ';' ]);
end

out = Tree;
    

