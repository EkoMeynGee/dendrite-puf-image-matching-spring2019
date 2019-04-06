function exactCorrectNum = mathcedPairsChecker(po_mat, threshold, image1, image2)
%%po_mat functin will do the check for every pairs of matchedNodes of two
%%image dendrite graphs, the input po-mat cotains x1, y1, x2, y2 respectively

%%Some preprocess for homography_mat method, the input pairs only works for
%%ensured matched pairs

po_mat_test = po_mat(:,[1 2]);
po_mat_ref = po_mat(:,[3 4]);
po_t_r_diff = po_mat_test - po_mat_ref;

po_dist = newNorm(po_t_r_diff);

if size(po_mat,1) < 4
    exactCorrectNum = 0;
    return;
else
    [~,I] = mink(po_dist,4);
end

po_selected = po_mat(I,:);

%%the H1_mat, making the the test nodes transform to the reference node domain 
H_transform_mat_1 = homography_mat(po_selected(:,1), po_selected(:,2),...
    po_selected(:,3), po_selected(:,4));


%%the H2_mat, making the the reference nodes transform to the test node image domain 
H_transform_mat_2 = homography_mat(po_selected(:,3), po_selected(:,4),...
    po_selected(:,1), po_selected(:,2));

%%Checker
%%count1 is the num of correct matched node for test nodes set
%%count2 is the num of correct matched node for reference nodes set
count1 = 0;
count2 = 0;
success1 = [];
success2 = [];
for index = 1:size(po_mat,1)
    tempA = [po_mat(index,1); po_mat(index,2); 1];
    tempB = [po_mat(index,3); po_mat(index,4); 1];
    tempB_trans = H_transform_mat_1 * tempB;
    tempA_trans = H_transform_mat_2 * tempA;
    tempA_trans = tempA_trans(1:2)/tempA_trans(3);
    tempB_trans = tempB_trans(1:2)/tempB_trans(3);
    L1_dist = norm(tempA_trans - tempB([1,2]));
    L2_dist = norm(tempB_trans - tempA([1,2]));
    if L1_dist < threshold
        count1 = count1 + 1;
        success1 = [success1; po_mat(index,:)];
    end
    
    if L2_dist < threshold
        count2 = count2 + 1;
        success2 = [success2; po_mat(index,:)];
    end
end

[exactCorrectNum, I] = min([count1, count2]);

if I == 1
    success = success1;
else 
    success = success2;
end

[h1, w1] = size(image1);
[h2, w2] = size(image2);
image_append = [image1, image2];
figure, imshow(image_append)
hold on
for index = 1:exactCorrectNum
    line([success(index,1), success(index,3)+w1], [success(index,2), success(index,4)])
end
hold off



function out = newNorm(diff_mat)
%%just a small little function to caculate the Elucidean distance for each
%%row

out = zeros(size(diff_mat,1),1);

for index = 1:length(out)
    out(index) = norm(diff_mat(index,:));
end
