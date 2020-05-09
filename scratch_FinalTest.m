clear
% filenm = 'c_other49.png';
% scratched_filenm = 'export.png';

filenm = 'c_other34.png';
scratched_filenm = 'export2.png';

org_skleton = colorextract(filenm);
scratched_skleton = colorextract(scratched_filenm);

% pre-steup paramters, could be find by hough_circle.m function method
cir.x = 400;
cir.y = 400;
cir.radius = 36;

figure, imshow(imread(scratched_filenm),'Border','tight');
[tree_test, ~, cell_test] = graph_based_rdGen(scratched_skleton, cir);
figure, imshow(imread(filenm),'Border','tight');
[tree_ref, ~, cell_ref] = graph_based_rdGen(org_skleton, cir);

[consistentMatchedTree1, matchingRate, consistentMatchedTree2, iter_mat] = mappingTest_Fast(tree_test,tree_ref,...
    .7,struct,struct,0,tree_test,tree_ref,0,1,[],[]);

