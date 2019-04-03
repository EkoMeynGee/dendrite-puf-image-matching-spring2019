function H_mat = homography_mat(x1_set, y1_set, x2_set, y2_set)
%%This function will calculate the homograpy transformation mat based on
%%the matched dots pairs, which (x1, y1) are from the test pic, (x2, y2)
%%are from the reference pic

% H = [h11 h12 h13; h21 h22 h23; h31 h32 h33];
% h = H';
% h = h(1:end-1);

num = numel(x1_set);
n9_1 = [x1_set, y1_set, ones(num,1), zeros(num,3), (-x1_set .* x2_set),...
    (-y1_set .* x2_set), -x2_set]; 

n9_2 = [zeros(num,3), x1_set, y1_set, ones(num,1), (-x1_set .* y2_set),...
    (-y1_set .* y2_set), -y2_set];

solve_mat = [n9_1;n9_2];

[~,~,V] = svd(solve_mat);
H = V(:,end);
H_mat = reshape(H,3,3);
H_mat = H_mat';
H_mat
% H = linsolve(solve_mat,[x2_set(:);y2_set(:)]);
% H_mat = reshape([H;1],3,3);
% H_mat = H_mat';
% H_mat
