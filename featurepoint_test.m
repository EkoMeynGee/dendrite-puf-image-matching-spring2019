% General method by using Feature point extraction
% 
% %% Harris
% I1 = rgb2gray(imread('b1.png'));
% I2 = rgb2gray(imread('b1rotat.png'));
% 
% points1 = detectHarrisFeatures(I1);
% points2 = detectHarrisFeatures(I2);
% 
% [f1,vpts1] = extractFeatures(I1,points1);
% [f2,vpts2] = extractFeatures(I2,points2);
% 
% indexPairs = matchFeatures(f1,f2) ;
% matchedPoints1 = vpts1(indexPairs(:,1));
% matchedPoints2 = vpts2(indexPairs(:,2));
% 
% figure; 
% ax = axes;
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
% title(ax, 'Harris Features point matches');
% legend(ax,'matched points 1','matched points 2');
% 
% 
% %% SURF
% I1 = rgb2gray(imread('b1.png'));
% I2 = rgb2gray(imread('b1rotat.png'));
% 
% points1 = detectSURFFeatures(I1);
% points2 = detectSURFFeatures(I2);
% 
% [f1,vpts1] = extractFeatures(I1,points1);
% [f2,vpts2] = extractFeatures(I2,points2);
% 
% indexPairs = matchFeatures(f1,f2) ;
% matchedPoints1 = vpts1(indexPairs(:,1));
% matchedPoints2 = vpts2(indexPairs(:,2));
% 
% figure; 
% ax = axes;
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
% title(ax, 'SURF Features point matches');
% legend(ax,'matched points 1','matched points 2');
% 
% 
% %% BRISK
% 
% I1 = rgb2gray(imread('b1.png'));
% I2 = rgb2gray(imread('b1rotat.png'));
% 
% points1 = detectBRISKFeatures(I1);
% points2 = detectBRISKFeatures(I2);
% 
% [f1,vpts1] = extractFeatures(I1,points1);
% [f2,vpts2] = extractFeatures(I2,points2);
% 
% indexPairs = matchFeatures(f1,f2) ;
% matchedPoints1 = vpts1(indexPairs(:,1));
% matchedPoints2 = vpts2(indexPairs(:,2));
% 
% figure; 
% ax = axes;
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
% title(ax, 'BRISK Features point matches');
% legend(ax,'matched points 1','matched points 2');
% 
% %% FAST
% 
% I1 = rgb2gray(imread('b1.png'));
% I2 = rgb2gray(imread('b1rotat.png'));
% 
% points1 = detectFASTFeatures(I1);
% points2 = detectFASTFeatures(I2);
% 
% [f1,vpts1] = extractFeatures(I1,points1);
% [f2,vpts2] = extractFeatures(I2,points2);
% 
% indexPairs = matchFeatures(f1,f2) ;
% matchedPoints1 = vpts1(indexPairs(:,1));
% matchedPoints2 = vpts2(indexPairs(:,2));
% 
% figure; 
% ax = axes;
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'montage', 'Parent', ax);
% title(ax, 'BRISK Features point matches');
% legend(ax,'matched points 1','matched points 2');

%% Tree structure based feature matching
sk = load('sk_test.mat');

sk = sk.sk;
sk_rt = imrotate(sk, 180);

para_ref = round(mean(hough_circle(sk, .5, .1, 33, 37, 1),2));
para_test = round(mean(hough_circle(sk_rt, .5, .1, 33, 37, 1),2));

circleRef.x = para_ref(2);
circleRef.y = para_ref(1);
circleRef.radius = para_ref(3);

circleTest.x = para_test(2);
circleTest.y = para_test(1);
circleTest.radius = para_test(3);

[tree_test, ~, cell_test] = graph_based_rdGen(sk_rt, circleTest);
% figure, imshow(sk_rt);
% viscircles([[cell_test{:,8}]', [cell_test{:,9}]'],ones(size(cell_test,1),1)*.5)

[tree_ref, ~, cell_ref] = graph_based_rdGen(sk, circleRef);
% figure, imshow(sk);
% viscircles([[cell_ref{:,8}]',[cell_ref{:,9}]'],ones(size(cell_ref,1),1)*.5)

[consistentMatchedTree1, matchingRate, consistentMatchedTree2, iter_mat] = mappingTest(tree_test,tree_ref,...
    .7,struct,struct,0,tree_test,tree_ref,0,1,[]);

master_i = rgb2gray(imread('b1.png'));
sub_i = rgb2gray(imread('b1rotat.png'));

po_mat = matchedNodeDrawLine(sk_rt, sk, consistentMatchedTree1, consistentMatchedTree2, sub_i, master_i);

hold on
viscircles([[cell_test{:,8}]', [cell_test{:,9}]'],ones(size(cell_test,1),1)*1)

viscircles([[cell_ref{:,8}]' + size(sk,2),[cell_ref{:,9}]'],ones(size(cell_ref,1),1)*1)
hold off










