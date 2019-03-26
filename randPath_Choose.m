function pathType = randPath_Choose(Prob_Matrix)
%%Based on the Probility matrix, we randomly choose a path

randomVector = [];
for index = 1:8
    tempProb = Prob_Matrix(index); 
    num = round(tempProb * 10000);
    if num == 0
        continue;
    end
    tempVector = index * ones(1, num);
    randomVector = [randomVector tempVector];
    
end

randomVector = randomVector(randperm(length(randomVector)));
%numel(randomVector)
randIndex = randi([1,numel(randomVector)]);

pathType = randomVector(randIndex);