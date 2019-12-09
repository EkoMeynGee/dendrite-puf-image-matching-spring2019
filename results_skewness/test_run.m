
rateTable = zeros(10,1);
fn = "c49.png";


i = 0;
for sigma = 0:0.0011:0.01
    i = i +1;
    fn_rt = imnoise(imread(fn),'gaussian', 0, sigma);
%     snr_table(i) = computeSNR(rgb2gray(imread(fn)), rgb2gray(fn_rt), 'd');
    sk = colorextract_artificial(fn, 'n');
    sk_rt = colorextract_artificial(fn_rt, 'n');
    circleRef.x = 400;
    circleRef.y = 400;
    circleRef.radius = 35;
    
    circleTest.x = 400;
    circleTest.y = 400;
    circleTest.radius = 35;
    
    [tree_test, ~, cell_test] = graph_based_rdGen(sk_rt, circleTest);
    [tree_ref, ~, cell_ref] = graph_based_rdGen(sk, circleRef);
    
    [consistentMatchedTree1, matchingRate, consistentMatchedTree2, iter_mat] = mappingTest_Fast(tree_test,tree_ref,...
        .7,struct,struct,0,tree_test,tree_ref,0,1,[],[]);
    rateTable(i) = (2 * numel(fieldnames(consistentMatchedTree1))) / (size(cell_ref,1) + size(cell_test,1));
end

pathname = './savedata/' + str(num);
save pathname rateTable