%% file definition
fn = 'b5.png';
rt_fn = fn;

%% Harris

I1 = rgb2gray(imread(fn));
I2 = rgb2gray(imread(rt_fn));


points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure; 
% ax = subplot(3,2,1);
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'Parent', ax);
title(ax, 'Harris Features point matches');
legend(ax,'matched points 1','matched points 2');

%% Min Eigen
I1 = rgb2gray(imread(fn));
I2 = rgb2gray(imread(rt_fn));

points1 = detectMinEigenFeatures(I1);
points2 = detectMinEigenFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure; 
% ax = subplot(3,2,2);
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'Parent', ax);
title(ax, 'Min Eigen Features point matches');
legend(ax,'matched points 1','matched points 2');

%% SURF

I1 = rgb2gray(imread(fn));
I2 = rgb2gray(imread(rt_fn));

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure;
% ax = subplot(3,2,3); 
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'Parent', ax);
title(ax, 'SURF Features point matches');
legend(ax,'matched points 1','matched points 2');
% 

%% BRISK

I1 = rgb2gray(imread(fn));
I2 = rgb2gray(imread(rt_fn));

points1 = detectBRISKFeatures(I1);
points2 = detectBRISKFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure;
% ax = subplot(3,2,4); 
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'Parent', ax);
title(ax, 'BRISK Features point matches');
legend(ax,'matched points 1','matched points 2');

%% FAST

I1 = rgb2gray(imread(fn));
I2 = rgb2gray(imread(rt_fn));

points1 = detectFASTFeatures(I1);
points2 = detectFASTFeatures(I2);

[f1,vpts1] = extractFeatures(I1,points1);
[f2,vpts2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

figure; 
% ax = subplot(3,2,5);
ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2, 'Parent', ax);
title(ax, 'FAST Features point matches');
legend(ax,'matched points 1', 'matched points 2');

%% Tree structure based feature matching

sk = colorextract(fn);

sk_rt = sk;

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

master_i = rgb2gray(imread(fn));
sub_i = rgb2gray(imread(rt_fn));

% subplot(3,2,6);
figure
po_mat = matchedNodeDrawLine(sk_rt, sk, consistentMatchedTree1, consistentMatchedTree2, sub_i, master_i, 'overlap');

hold on
% viscircles([[cell_test{:,8}]', [cell_test{:,9}]'],ones(size(cell_test,1),1)*1)
p1 = plot([cell_test{:,8}], [cell_test{:,9}], 'LineStyle', 'none', 'Marker', 'o', 'Color',...
 'r', 'DisplayName', 'matched points 1');

% viscircles([[cell_ref{:,8}]' + size(sk,2),[cell_ref{:,9}]'],ones(size(cell_ref,1),1)*1)
p2 = plot([cell_ref{:,8}], [cell_ref{:,9}], 'LineStyle', 'none', 'Marker', '+',...
 'Color', 'g', 'DisplayName', 'matched points 2');
title('Tree structure based Features matches');
legend([p1,p2], {'matched points 1', 'matched pints 2'});
hold off


