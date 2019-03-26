function newProbMat = reAssign_Prob_Matrix(dirType, oldProbMat)
%%Based on the direction it went, re-assign probility matrix
newProbMat = zeros(1,8);
newProbMat(dirType) = oldProbMat(dirType) * 0.99;
diff = (oldProbMat(dirType) - newProbMat(dirType))/7;

for index = 1:8
    if (index == dirType)
        continue;
    end
    newProbMat(index) = oldProbMat(index) + diff;
end

