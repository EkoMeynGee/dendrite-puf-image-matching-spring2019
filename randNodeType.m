function nodeType = randNodeType()
%'1' end nodes, '2' bifuration nodes, '3' usalpoints 
%   Detailed explanation goes here

Prob_Matrix = [0.043 0.08 0.89];
Prob_Matrix = Prob_Matrix / sum(Prob_Matrix);

randomVector = [];

for index = 1:3
    tempProb = Prob_Matrix(index); 
    num = round(tempProb * 10000);
    if num == 0
        continue;
    end
    tempVector = index * ones(1, num);
    randomVector = [randomVector tempVector];
    
end

randomVector = randomVector(randperm(length(randomVector)));

randIndex = randi([1,numel(randomVector)]);

nodeType = randomVector(randIndex);

