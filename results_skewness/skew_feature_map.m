type = 34;
numbersamples = 150;
refIm = eval(['"c' num2str(type) '.png";']);
ref = colorextract_artificial(refIm, 'n');
para_ref = round(mean(hough_circle(ref, .5, .1, 30, 37, 1),2));
circleRef.x = para_ref(2);
circleRef.y = para_ref(1);
circleRef.radius = para_ref(3);
[tree_ref, ~, cell_ref] = graph_based_rdGen(ref, circleRef);


rate = zeros(150,1);
for index = 1:2:numbersamples
    
    eval(['filename = "sc' num2str(type) 'k' num2str(index) '.png";']);
    try
        im_t = colorextract_artificial(filename, 'n');
        para_test = round(mean(hough_circle(im_t, .5, .1, 30, 37, 1),2));
        circleTest.x = para_test(2);
        circleTest.y = para_test(1);                                                                            
        circleTest.radius = para_test(3);
        [tree_test, ~, cell_test] = graph_based_rdGen(im_t, circleTest);
        [consistentMatchedTree1, matchingRate, consistentMatchedTree2, iter_mat] =...
            mappingTest_Fast(tree_test,tree_ref,.7,struct,struct,0,tree_test,tree_ref,0,1,[],[]);
        
        rate(index) = (2 * numel(fieldnames(consistentMatchedTree1))) / (size(cell_ref,1) + size(cell_test,1));
    catch
        rate(index) = 0;
    end
end
