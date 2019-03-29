function matchedNodeDrawLine(image1, image2, consistentMatchedTree1, consistentMatchedTree2)
%%This function is designed for debug and visulize the matching dots
%%between 2 dendrite PUF

[h1, w1] = size(image1);
[h2, w2] = size(image2);
image_append = [image1, image2];

matchedNum = numel(fieldnames(consistentMatchedTree1));
tree1Names = fieldnames(consistentMatchedTree1);
tree2Names = fieldnames(consistentMatchedTree2);
%tempTree2 = consistentMatchedTree2;
po_mat = zeros(matchedNum, 4);
figure, imshow(image_append)
hold on
for index = 1:matchedNum
    eval(['temp1x = consistentMatchedTree1.' tree1Names{index} '.x']);
    eval(['temp1y = consistentMatchedTree1.' tree1Names{index} '.y']);
    eval(['temp2x = consistentMatchedTree2.' tree2Names{index} '.x + w1']);
    eval(['temp2y = consistentMatchedTree2.' tree2Names{index} '.y']);
    %eval(['tempTree2.' tree2Names{index} '.x = temp2x + w1']);
    line([temp1x, temp2x], [temp1y, temp2y], 'Color', 'green','LineStyle','--');
end



