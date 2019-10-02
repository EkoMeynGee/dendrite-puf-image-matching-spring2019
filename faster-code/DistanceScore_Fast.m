function relative_d = DistanceScore_Fast(index_tree1,index_tree2,tree_mat1,tree_mat2,param,factor)
% This function is made to determine the distance similarity scores
% Two inputs are two node structures.
% This is a recursive function.

% [1: node.index,
%  2: node.relativeLen,
%  3: node.angle,
%  4: distRoot,
%  5: node.parentIndex,
%  6: node.siblingIndex];

relative_dist = abs(tree_mat1(index_tree1, 2) - tree_mat2(index_tree2, 2));
relative_angle = abs(tree_mat1(index_tree1, 3) - tree_mat1(index_tree1, 3));
relative_d = norm([sqrt(factor)*relative_dist, sqrt(1-factor)*relative_angle]);
index_p1 = tree_mat1(index_tree1,5);
index_p2 = tree_mat2(index_tree2,5);

iter = 0;
while(1)
    iter = iter + 1;
    if ((index_p1 == 0) || (index_p2 == 0))
        break;
    end
    sub_dist = abs(tree_mat1(index_p1, 2) - tree_mat2(index_p2, 2));
    sub_angle = abs(tree_mat1(index_p1, 3) - tree_mat1(index_p2, 3));
    sub_d = norm([sqrt(factor)*sub_dist, sqrt(1-factor)*sub_angle]);
    index_p1 = tree_mat1(index_p1,5);
    index_p2 = tree_mat2(index_p2,5);
    
    relative_d = relative_d + (param^iter) * sub_d;
end