function algfixTesting(testIMG, refIMG)
%%A function, trying to fix the porblem of matching not really good, with 2
%%image matrix. Load 2 data.mat before run this function.

figure, imshow(testIMG);
figure, imshow(refIMG);

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

para_ref = round(mean(hough_circle(refIMG, .1, .1, 33, 37, 1),2));
para_test = round(mean(hough_circle(testIMG, .2, .1, 33, 37, 1),2));
[TreeStruct, new_result, cellnodes] = graph_based_rdGen(refIMG, circleInfo)

