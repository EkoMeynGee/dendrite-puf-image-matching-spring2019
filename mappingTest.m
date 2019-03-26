function [ConsistentMatchTree, matchingRate] = mappingTest(Tree1,Tree2,...
    param,ConsistentMatchTree,ConsistentMatchTree2,iterTimes,FullTree1,FullTree2,matchingRate)
%%This function is made for testing mapping algrothim
%%Tree1 always is the testing tree

alfa = .4;
beta = .9;
gamma = .9;
InconsistentTree1 = struct;
InconsistentTree2 = struct;
consisCriterion1 = (1/3)*(alfa + alfa^2 + beta + gamma);
consisCriterion2 = (1/6)*(alfa + alfa^2 + beta + gamma);

[LinkedTree1, LinkedTree2] = mappingAndLink(Tree1,Tree2,param,FullTree1,FullTree2);

testingNum = numel(fieldnames(LinkedTree1));
dataNum = numel(fieldnames(LinkedTree2));
testingFields = fieldnames(LinkedTree1);
dataFields = fieldnames(LinkedTree2);

%%Initialize the LinkedTree2, and LinkedTree1------------------------------
%%-------------------------------------------------------------------------
for index = 1:testingNum
    eval(['LinkedTree1.' testingFields{index} '.consisResult = "";']);
end

for index = 1:dataNum
    eval(['LinkedTree2.' dataFields{index} '.consisResult = "";']);
end

for index = 1:testingNum
    eval(['LinkedNodeIndex = LinkedTree1.' testingFields{index} '.linkTo;']);
    
    if (isempty(LinkedNodeIndex))
        eval(['LinkedTree1.' testingFields{index} '.consistencyScore = 0;']);
        eval(['LinkedTree1.' testingFields{index}...
            '.consisResult = "inconsistent";']);
        eval(['InconsistentTree1.' testingFields{index}....
            ' = LinkedTree1.' testingFields{index} ';']);
        continue;
    else
        %%cat two structs into 1 struct
        exMatchedNum = numel(fieldnames(ConsistentMatchTree));
        exMatchedFields = fieldnames(ConsistentMatchTree);
        CatTree1 = LinkedTree1;
        exMatchedNum2 = numel(fieldnames(ConsistentMatchTree2));
        exMatchedFields2 = fieldnames(ConsistentMatchTree2);
        CatTree2 = LinkedTree2;
        for indextt = 1:exMatchedNum
            eval(['CatTree1.' exMatchedFields{indextt}...
                ' = ConsistentMatchTree.' exMatchedFields{indextt} ';']);
        end
            
        for indexdd = 1:exMatchedNum2
            eval(['CatTree2.' exMatchedFields2{indexdd}...
                ' = ConsistentMatchTree2.' exMatchedFields2{indexdd} ';']);
        end
        %%-----------------------------------------------------------------
        
        eval(['score = cosistencyScore(LinkedTree1.' testingFields{index}...
            ', LinkedTree2.n' num2str(LinkedNodeIndex)...
            ', CatTree1, CatTree2, alfa, beta, gamma);']);
        eval(['LinkedTree1.' testingFields{index}...
            '.consistencyScore = score;']);
        eval(['LinkedTree2.n' num2str(LinkedNodeIndex)...
            '.consistencyScore = score;']);
    end
    
    if (score <= consisCriterion1 && score > consisCriterion2)
        eval(['LinkedTree1.' testingFields{index}...
            '.consisResult = "consistent";']);
        eval(['LinkedTree2.n' num2str(LinkedNodeIndex)...
            '.consisResult = "consistent";']);
        eval(['ConsistentMatchTree.' testingFields{index}...
            ' = LinkedTree1.' testingFields{index} ';']);
        eval(['ConsistentMatchTree2.n' num2str(LinkedNodeIndex)...
            ' = LinkedTree2.n' num2str(LinkedNodeIndex) ';']);
    else
        eval(['LinkedTree1.' testingFields{index}...
            '.consisResult = "inconsistent";']);
        eval(['LinkedTree2.n' num2str(LinkedNodeIndex)...
            '.consisResult = "inconsistent";']);
        eval(['InconsistentTree1.' testingFields{index}...
            '= LinkedTree1.' testingFields{index} ';']);
        eval(['InconsistentTree2.n' num2str(LinkedNodeIndex)...
            '= LinkedTree2.n' num2str(LinkedNodeIndex) ';']);
    end
end

for indexd = 1:dataNum
    eval(['judgestr = LinkedTree2.' dataFields{indexd} '.consisResult;']);
    if (judgestr == "")
        eval(['InconsistentTree2.' dataFields{indexd}...
            '= LinkedTree2.' dataFields{indexd} ';']);
    end
end
%%So far,Get two inconsistent tree, and recursion do the remapping by changing
%%param for DISTANCESOCRE function
%%-------------------------------------------------------------------------

inconsisTestingNum = numel(fieldnames(InconsistentTree1));
inconsisDataNum = numel(fieldnames(InconsistentTree2));
matchedNum = numel(fieldnames(ConsistentMatchTree));
ogDataNum = numel(fieldnames(FullTree2));

matchingRateDiff = matchedNum/ogDataNum - matchingRate;
fprintf("the last matchingRate Difference is %d !\n", round((matchingRateDiff*100), 3, 'significant'));
matchingRate = matchingRate + (0.7^iterTimes)*matchingRateDiff;

if (inconsisTestingNum == 0 ||inconsisDataNum == 0 || iterTimes == 5 || matchingRateDiff < 0.05)
    return;
else
    [ConsistentMatchTree, matchingRate] = mappingTest(InconsistentTree1,...
        InconsistentTree2, param/2, ConsistentMatchTree,  ConsistentMatchTree2,...
        iterTimes + 1, FullTree1, FullTree2, matchingRate);
end
