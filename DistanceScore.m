function out = DistanceScore(node1,node2,Tree1,Tree2,param,FullTree1,FullTree2)
% This function is made to determine the distance similarity scores
% Two inputs are two node structures.
% This is a recursive function.

relative_dist = abs(node1.relativeLen - node2.relativeLen);
relative_angle = abs(node1.angle - node2.angle);
relative_d = norm([relative_dist, relative_angle]);

if (isempty(node1.parentIndex )|| isempty(node2.parentIndex))
    out = relative_d;
    return;
end

eval(['RelativeDist = relative_d + param*DistanceScore(FullTree1.n'...
    num2str(node1.parentIndex) ', FullTree2.n' num2str(node2.parentIndex)...
    ',Tree1,Tree2,param,FullTree1,FullTree2);']);

out = RelativeDist;

