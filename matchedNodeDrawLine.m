function po_mat = matchedNodeDrawLine(image1, image2, consistentMatchedTree1, consistentMatchedTree2, varargin)
%%This function is designed for debug and visulize the matching dots
%%between 2 dendrite PUF

[h1, w1] = size(image1);
[h2, w2] = size(image2);

matchedNum = numel(fieldnames(consistentMatchedTree1));
tree1Names = fieldnames(consistentMatchedTree1);
tree2Names = fieldnames(consistentMatchedTree2);
po_mat = zeros(matchedNum, 4);

if isempty(varargin)
    image1 = (image1*-1 + 1);
    image2 = (image2*-1 + 1);
    image_append = [image1, image2];
    image_append = image_append(:,[201:600, 1001:1400]);
    %tempTree2 = consistentMatchedTree2;
    figure,imshow(image_append);
    hold on
    for index = 1:matchedNum
        eval(['temp1x = consistentMatchedTree1.' tree1Names{index} '.x-200;']);
        eval(['temp1y = consistentMatchedTree1.' tree1Names{index} '.y;']);
        eval(['temp2x = consistentMatchedTree2.' tree2Names{index} '.x + w1 - 600;']);
        eval(['temp2y = consistentMatchedTree2.' tree2Names{index} '.y;']);
        %eval(['tempTree2.' tree2Names{index} '.x = temp2x + w1']);
        po_mat(index,:) = [temp1x+200, temp1y, temp2x-w1+600, temp2y];
        line([temp1x, temp2x], [temp1y, temp2y], 'Color', 'y','LineStyle','--');
    end
    
    hold off;
else
    sub_i = varargin{1};
    master_i = varargin{2};
    image_append = [sub_i, master_i];
    figure, imshow(image_append);
    hold on    
    for index = 1:matchedNum
        eval(['temp1x = consistentMatchedTree1.' tree1Names{index} '.x;']);
        eval(['temp1y = consistentMatchedTree1.' tree1Names{index} '.y;']);
        eval(['temp2x = consistentMatchedTree2.' tree2Names{index} '.x + w1;']);
        eval(['temp2y = consistentMatchedTree2.' tree2Names{index} '.y;']);
        %eval(['tempTree2.' tree2Names{index} '.x = temp2x + w1']);
        po_mat(index,:) = [temp1x, temp1y, temp2x-w1, temp2y];
        line([temp1x, temp2x], [temp1y, temp2y], 'Color', 'y','LineStyle','--');
    end
    
    hold off;
    
end


