function out = DistanceScore(node1,node2,Tree1,Tree2,param,FullTree1,FullTree2,factor, n_step, info)
% This function is made to determine the distance similarity scores
% Two inputs are two node structures.
% This is a recursive function.

relative_dist = abs(node1.relativeLen - node2.relativeLen);
relative_angle = abs(node1.angle - node2.angle);
relative_d = norm([sqrt(factor)*relative_dist, sqrt(1-factor)*relative_angle]);

if (isempty(node1.parentIndex )|| isempty(node2.parentIndex))
    out = relative_d;
    return;
end

eval(['RelativeDist = relative_d + param*DistanceScore(FullTree1.n'...
    num2str(node1.parentIndex) ', FullTree2.n' num2str(node2.parentIndex)...
    ',Tree1,Tree2,param,FullTree1,FullTree2,factor);']);

out = RelativeDist;

% if (isempty(node1.parentIndex) && isempty(node2.parentIndex))
% 	diff_step = n_step.A - n_step.B;
% 	out = diff_step;
% 	info.A = info.A + param*node1.relativeLen;
% 	info.B = info.B + param*node2.relativeLen;
% end

% if ((~isempty(node1.parentIndex)) && (~isempty(node2.parentIndex)))
% 	n_step.A = n_step.A + 1;
% 	n_step.B = n_step.B + 1;
% 	eval(['[out, info] = DistanceScore(FullTree1.n' num2str(node1.parentIndex)...
% 	 ', FullTree2.n' num2str(node2.parentIndex)  ', Tree1, Tree2,param,FullTree1,FullTree2,factor,n_step, info);']);
% 	info.A = info.A + param*node1.relativeLen;
% 	info.B = info.B + param*node2.relativeLen;
% elseif (isempty(node1.parentIndex) && (~isempty(node2.parentIndex)))
% 	n_step.B = n_step.B + 1;
% 	eval(['[out, info] = DistanceScore(FullTree1.n' num2str(node1.index)...
% 	 ', FullTree2.n' num2str(node2.parentIndex)  ', Tree1, Tree2,param,FullTree1,FullTree2,factor,n_step, info);']);
% 	info.B = info.B + param*node2.relativeLen;
% elseif (~isempty(node1.parentIndex) && isempty(node2.parentIndex))
% 	n_step.A = n_step.A + 1;
% 	eval(['[out, info] = DistanceScore(FullTree1.n' num2str(node1.parentIndex)...
% 	 ', FullTree2.n' num2str(node2.index)  ', Tree1, Tree2,param,FullTree1,FullTree2,factor,n_step, info);']);
% 	info.A = info.A + param*node1.relativeLen;
% end

% if ((n_step.A == 1) && (n_step.B == 1))
% 	out = abs(info.A - info.B);
% end
