function algfixTesting(testIMG, refIMG)
%%A function, trying to fix the porblem of matching not really good, with 2
%%image matrix. Load 2 data.mat before run this function.

% figure, imshow(testIMG);
% figure, imshow(refIMG);

% extractionIMG = zeros(800, 800);
% testIMG_struct = bwconncomp(testIMG, 26);
% data = regionprops(testIMG_struct,'basic');
% dataArea = [data.Area];
% [~,idx] = max(dataArea);
% extractionIMG(testIMG_struct.PixelIdxList{idx}) = true;
%
% testIMG = extractionIMG;
% figure, imshow(testIMG);

% [y, x] = find(testIMG == 1);
% portion_y = y( (~((y == 1) | (y == size(testIMG,1)))) & (~((x == 1) | (x == size(testIMG,2)))) );
% portion_x = x( (~((y == 1) | (y == size(testIMG,1)))) & (~((x == 1) | (x == size(testIMG,2)))) );
%
% testIMG(1,:) = 0;
% testIMG(end,:) = 0;
% testIMG(:,1) = 0;
% testIMG(:,end) = 0;
% for index = 1:length(portion_y)
%     a = portion_y(index);
%     b = portion_x(index);
%     if (testIMG(a-1,b) == 1) || (testIMG(a+1,b) == 1)...
%             || (testIMG(a,b-1) == 1) || (testIMG(a,b+1) == 1) ||...
%             (testIMG(a-1,b-1) == 1) || (testIMG(a+1,b-1) == 1) ||...
%             (testIMG(a-1,b+1) == 1) || (testIMG(a+1,b+1) == 1)
%         continue
%     end
%
%     testIMG(a,b) = 0;
% end
% figure, imshow(testIMG)

para_ref = round(mean(hough_circle(refIMG, .5, .1, 33, 37, 1),2));
para_test = round(mean(hough_circle(testIMG, .5, .1, 33, 37, 1),2));

circleRef.x = para_ref(1);
circleRef.y = para_ref(2);
circleRef.radius = para_ref(3);

circleTest.x = para_test(1);
circleTest.y = para_test(2);
circleTest.radius = para_test(3);

[tree_test, mat_test, cell_test] = graph_based_rdGen(testIMG, circleTest);
figure, imshow(testIMG);
viscircles([[cell_test{:,8}]', [cell_test{:,9}]'],ones(size(cell_test,1),1)*.5)

[tree_ref, mat_ref, cell_ref] = graph_based_rdGen(refIMG, circleRef);
figure, imshow(refIMG);
viscircles([[cell_ref{:,8}]',[cell_ref{:,9}]'],ones(size(cell_ref,1),1)*.5)

[consistentMatchedTree1, matchingRate, consistentMatchedTree2] = mappingTest(tree_test,tree_ref,...
    .7,struct,struct,0,tree_test,tree_ref,0);

po_mat = matchedNodeDrawLine(testIMG, refIMG, consistentMatchedTree1, consistentMatchedTree2);

exactCorrectNum = mathcedPairsChecker(po_mat, 10);

exactCorrectNum
matchingRate
