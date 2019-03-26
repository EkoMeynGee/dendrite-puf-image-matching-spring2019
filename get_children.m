function [ End_point,First_father,Fathers ] = get_children( nodes,parent,First_father,End_point,Fathers,nodestorage)
%GET_CHILDREN Summary of this function goes here
%   Detailed explanation goes here
[numberofnodes,numberofinfo] = size(parent);
for i=1:numberofnodes
    level=parent(i,5);
    % Set up the the parent cordinations
    x=parent(i,8);
    y=parent(i,9);
    % Finding match the same level themself and their parent's
    % cordinations, so that we can get the who is the children for the first
    % parent, and second parent, and etc.
    children = nodes(find(ismember(nodes(:,[5,6,7]),[level+1,x,y],'rows')),:);
%     disp('I am ')
    [numberofchildrennodes,numberofinfo1] = size(children);
    for j=1:numberofchildrennodes
        if(children(j,4)==1)  % type 1 should be the node have more than 2 sub-nodes
            if(~ismember(nodestorage,children(j,:),'rows'))
                nodestorage =[nodestorage ;children(j,:)];
                [ End_point,First_father,Fathers ] = get_children( nodes,children,First_father,End_point,Fathers,nodestorage);
            end
        else
            
            % END_POINT would be the distance between the child and first
            % father
            End_point=[End_point; sqrt((children(j,8)-First_father(1))^2+(children(j,9)-First_father(2))^2)];
            
        end
        
        
    end
end

end

