numbersamples = 50;

refIm = 'b6.png';
ref = colorextract(refIm);
para_ref = round(mean(hough_circle(ref, .5, .1, 33, 37, 1),2));
circleRef.x = para_ref(2);
circleRef.y = para_ref(1);
circleRef.radius = para_ref(3);
[tree_ref, ~, cell_ref] = graph_based_rdGen(ref, circleRef);


rate = zeros(numbersamples,1);

for index = 1:1
    
    
    eval(['filename = "sk' num2str(index) '.png";']);
    try
        im_t = colorextract(filename);
        para_test = round(mean(hough_circle(im_t, .5, .1, 33, 37, 1),2));
        circleTest.x = para_test(2);
        circleTest.y = para_test(1);
        circleTest.radius = para_test(3);
        [tree_test, ~, cell_test] = graph_based_rdGen(im_t, circleTest);
        [consistentMatchedTree1, matchingRate, consistentMatchedTree2, iter_mat] = mappingTest(tree_test,tree_ref,...
            .5,struct,struct,0,tree_test,tree_ref,0,.6,[]);
        rate(index-50) = matchingRate;
    catch
        rate(index-50) = 0;
    end
end
