% function run_d_methods()
% This function will go through most of methods of feature extration and with the same basic
% matching technique. In general, the image will have rotation, the image
% looks the same by human eye except the rotation, but the actual the rgb
% color is totally random for each image.


%% Built-in methods feature mapping
rateTable = zeros(50,50);
snr_table = zeros(50,1);
feature_all = zeros(50,50);
matched_all = zeros(50,50);
for i = 1:50
    eval(['fn = "c' num2str(i) '.png";']);
    I1 = rgb2gray(imread(fn));
    for j = 1:50
        eval(['fn_rt = "c_other' num2str(j) '.png";']);
        I2 = rgb2gray(imnoise(imread(fn_rt),'gaussian', 0, 0.01));
%         I2 = imrotate(rgb2gray(imread(fn_rt)),180);
        if i == j
            snr_table(i) = computeSNR(I1, I2, 'd');
        end
        points1 = detectHarrisFeatures(I1);
        points2 = detectHarrisFeatures(I2);
        
        [f1,vpts1] = extractFeatures(I1,points1);
        [f2,vpts2] = extractFeatures(I2,points2);
        
        indexPairs = matchFeatures(f1,f2) ;
        matchedPoints1 = vpts1(indexPairs(:,1));
        matchedPoints2 = vpts2(indexPairs(:,2));
        
        matched_all(j,i) = 2 * matchedPoints1.Count;
%         feature_all(j,i) = size(f1,1) + size(f2,1);
        feature_all(j,i) = f1.NumFeatures + f2.NumFeatures;
        rateTable(j,i) = (2 * matchedPoints1.Count) / feature_all(j,i);
        
        
    end
end

%% proposed method mapping

rateTable = zeros(50,1);
features = zeros(50,1);
matcheds = zeros(50,1);
for i = 1:50
    eval(['fn = "c' num2str(i) '.png";']);
%     eval(['fn_rt = "c_other' num2str(i) '.png";']);
    sk = colorextract_artificial(fn, 'n');
    
    fn_rt = imnoise(imread(fn),'gaussian', 0, 0.01);
    sk_rt = colorextract_artificial(fn_rt, 'n');
    
    para_ref = round(mean(hough_circle(sk, .5, .1, 36, 36, 1),2));
    para_test = round(mean(hough_circle(sk_rt, .5, .1, 36, 36, 1),2));
    
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
    
    %[consistentMatchedTree1, matchingRate, consistentMatchedTree2, iter_mat] = mappingTest(tree_test,tree_ref,...
      %  .7,struct,struct,0,tree_test,tree_ref,0,1,[]);
    
%     (2 * numel(fieldnames(consistentMatchedTree1))) / (size(cell_ref,1) + size(cell_test,1))
    rateTable(i) = (2 * numel(fieldnames(consistentMatchedTree1))) / (size(cell_ref,1) + size(cell_test,1));
    features(i) = size(cell_ref,1) + size(cell_test,1);
    matcheds(i) = 2 * numel(fieldnames(consistentMatchedTree1));
end



%% extract the rate
[maxval,i] = max(rateTable,[],2);
correct_rate = maxval(i == [1:50]');
a = find(i == [1:50]');
b = diag(feature_all);
c = diag(matched_all);
meanextracted = mean(mean(feature_all));
meancorrect = mean(c(a));
