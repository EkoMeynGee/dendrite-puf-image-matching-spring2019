%% file definition

build_scratch_test_dataBase()


%% scrath_file setting
name = "./waited_use/b1.png";
data_img = 'b1.png';

test_img = rgb2gray(imread(name));
other_img = rgb2gray(imrotate(imread(data_img),180));

middle_i = [size(test_img,2)/2, size(other_img,1)/2];
% imshow(other_img)
% figure
% imshow(test_img)

points1 = detectFASTFeatures(test_img);
points2 = detectFASTFeatures(other_img);

[f1,vpts1] = extractFeatures(test_img,points1);
[f2,vpts2] = extractFeatures(other_img,points2);

indexPairs = matchFeatures(f1,f2) ;
matchedPoints1 = vpts1(indexPairs(:,1));
matchedPoints2 = vpts2(indexPairs(:,2));

num = size(matchedPoints1,1);
rough_matched_ratio = 2*num/(f2.NumFeatures+f1.NumFeatures)
% true_correct = scratch_checker(matchedPoints1, matchedPoints2, 10);
true_correct = rt_checker(matchedPoints1.Location, matchedPoints2.Location,middle_i, 10)


%% data-base 
sk = colorextract(name);
sk_rt = imrotate(colorextract(data_img), 180);

para_ref = round(mean(hough_circle(sk, .5, .1, 33, 37, 1),2));
para_test = round(mean(hough_circle(sk_rt, .5, .1, 33, 37, 1),2));

circleRef.x = para_ref(2);
circleRef.y = para_ref(1);
circleRef.radius = para_ref(3);

circleTest.x = para_test(2);
circleTest.y = para_test(1);
circleTest.radius = para_test(3);

[tree_test, ~, cell_test] = graph_based_rdGen(sk_rt, circleTest);

[tree_ref, ~, cell_ref] = graph_based_rdGen(sk, circleRef);

[consistentMatchedTree1, matchingRate, consistentMatchedTree2, iter_mat] = mappingTest(tree_test,tree_ref,...
    .5,struct,struct,0,tree_test,tree_ref,0,.6,[]);




function true_correct = scratch_checker(matchp1, matchp2, offset)
    mse = abs(matchp1.Location - matchp2.Location);
    true_correct = sum(sum(mse,2) < offset);
end


function build_scratch_test_dataBase()

total = 15;
for index = 1:total
    eval(['fn = "b' num2str(index) '.png";']);
    sk = colorextract(fn);
    para_ref = round(mean(hough_circle(sk, .5, .1, 33, 37, 1),2));
    circleRef.x = para_ref(2);
    circleRef.y = para_ref(1);
    circleRef.radius = para_ref(3);
    [tree_struct, ~, ~] = graph_based_rdGen(sk, circleRef);
    eval(['scratch_dataBase.Tree' num2str(index) ' = tree_struct;']);
end
    save scratch_db1 scratch_dataBase
end