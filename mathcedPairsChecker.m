function exactCorrectNum = mathcedPairsChecker(po_mat, threshold)
%%po_mat functin will do the check for every pairs of matchedNodes of two
%%image dendrite graphs, the input po-mat cotains x1, y1, x2, y2 respectively

%%the H1_mat, making the the test nodes transform to the reference node domain 
H_transform_mat_1 = homography_mat(po_mat(:,1), po_mat(:,2),...
    po_mat(:,3), po_mat(:,4));


%%the H2_mat, making the the reference nodes transform to the test node image domain 
H_transform_mat_2 = homography_mat(po_mat(:,3), po_mat(:,4),...
    po_mat(:,1), po_mat(:,2));

%%Checker
%%count1 is the num of correct matched node for test nodes set
%%count2 is the num of correct matched node for reference nodes set
count1 = 0;
count2 = 0;
for index = 1:size(po_mat,1)
    tempA = [po_mat(index,1); po_mat(index,2); 1];
    tempB = [po_mat(index,3); po_mat(index,4); 1];
    tempB_trans = H_transform_mat_1 * tempB;
    tempA_trans = H_transform_mat_2 * tempA;
    tempA_trans = tempA_trans(1:2)/tempA_trans(3);
    tempB_trans = tempB_trans(1:2)/tempB_trans(3);
    L1_dist = norm(tempA_trans - po_mat(index,[1,2]));
    L2_dist = norm(tempB_trans - po_mat(index,[3 4]));
    if L1_dist < threshold
        count1 = count1 + 1;
    end
    
    if L2_dist < threshold
        count2 = count2 + 1;
    end
end

exactCorrectNum = min(count1, count2);

