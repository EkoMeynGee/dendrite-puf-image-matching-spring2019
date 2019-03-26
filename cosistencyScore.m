function score = cosistencyScore(node1, node2, LinkedTree1, LinkedTree2...
    , alfa, beta, gamma)
%%Obtain the cosistency of value of tw..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................o nodes.
%%------------------------------------------------------------------------
%%Important%%%%
%%Precondition: node1 and node2 must be 2 linked nodes.
%%------------------------------------------------------------------------
%%We have Three paramters here, alfa, beta, gamma
%%0 < alfa < 1/2, 0 < beta < 1, 0 < gamma < 1
if (isempty(node1.parentIndex) && isempty(node2.parentIndex))
    score = alfa + alfa^2;
elseif((isempty(node1.parentIndex) && ~isempty(node2.parentIndex))...
        || (~isempty(node1.parentIndex) && isempty(node2.parentIndex)))
    score = 0;  
else
    eval(['node1parent = LinkedTree1.n' num2str(node1.parentIndex) ';']);
    eval(['node2parent = LinkedTree2.n' num2str(node2.parentIndex) ';']);
    
    eval(['score = alfa*(isequal(LinkedTree1.n' num2str(node1.parentIndex)...
        '.linkTo, LinkedTree2.n' num2str(node2.parentIndex) '.index));']);
    
    if (isempty(node1parent.parentIndex) && isempty(node2parent.parentIndex))
        score = score + alfa^2;
    elseif((isempty(node1parent.parentIndex) && ~isempty(node2parent.parentIndex))...
            || (~isempty(node1parent.parentIndex) && isempty(node2parent.parentIndex)))
        score = score;
    else 
        eval(['score = score + (alfa^2)*(isequal(LinkedTree1.n'...
            num2str(node1parent.parentIndex) '.linkTo, LinkedTree2.n'...
            num2str(node2parent.parentIndex) '.index));']);
    end
end

%%childern mapped percentage
count = 0;
childIndexSet1 = node1.childIndex;
childIndexSet2 = node2.childIndex;
nL1 = length(childIndexSet1);
nL2 = length(childIndexSet2);
denominator = max(nL1,nL2);

%%Since the node1 is one of test node, so start with node1
for parIndex = 1:nL1
    eval(['result = ismember(LinkedTree1.n' num2str(childIndexSet1(parIndex))...
        '.linkTo, childIndexSet2);']);
    if (result)
        count = count + 1;
    end
end

if (denominator == 0)
    score = score + beta;
else
    score = score + beta*(count/denominator);
end

%%Sibling mapped percentage
count = 0;
siblingIndexSet1 = node1.siblingIndex;
siblingIndexSet2 = node2.siblingIndex;
num1 = length(siblingIndexSet1);
num2 = length(siblingIndexSet2);
denominator2 = max(num1,num2);

%%Since the node1 is one of test node, so start with node1
for paramIndex = 1:num1
    eval(['show = ismember(LinkedTree1.n' num2str(siblingIndexSet1(paramIndex))...
        '.linkTo, siblingIndexSet2);']);
    if (show)
        count = count + 1;
    end
end


if (denominator2 == 0)
    score = score + gamma;
else
    score = score + gamma*(count/denominator2);
end

score = 1/3*score;
