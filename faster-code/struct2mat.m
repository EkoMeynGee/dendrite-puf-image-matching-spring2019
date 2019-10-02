function tree_mat = struct2mat(tree)
% in order to make it program efficient, it is the function to convert the
% Tree struct to matrix

num = numel(fieldnames(tree));
tree_mat = zeros(num, 5);

for iter = 1:num
    node = eval(['tree.n' num2str(iter) ';']);
    pIndex = node.parentIndex;
    if (isempty(pIndex))
        pIndex = 0;
    end
    tree_mat(iter,:) = [node.index, node.relativeLen, node.angle, node.distRoot, pIndex];
end
    