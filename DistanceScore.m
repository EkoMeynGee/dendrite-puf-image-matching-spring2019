function out = DistanceScore(node1,node2,Tree1,Tree2,param,FullTree1,FullTree2)
% This function is made to determine the distance similarity scores
% Two inputs are two node structures.
% This is a recursive function.

Dist = abs(node1.relativeLen - node2.relativeLen);


if (isempty(node1.parentIndex )|| isempty(node2.parentIndex))
    out = Dist;
    return;
end

eval(['RelativeDist = Dist + param*DistanceScore(FullTree1.n'...
    num2str(node1.parentIndex) ', FullTree2.n' num2str(node2.parentIndex)...
    ',Tree1,Tree2,param,FullTree1,FullTree2);']);

out = RelativeDist;






