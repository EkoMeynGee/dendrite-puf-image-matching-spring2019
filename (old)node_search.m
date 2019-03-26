function result=node_search(junctions,image,parent,flag)

parent.level = parent.level+1;
parentreserve = parent;
%     nodes = [];
%     skelet = [];
indicator = [];
persistent skelet; 


persistent nodes;
persistent nodes_cordinates;
persistent endpoint_flag;
[w,h] = size(image);
endpoint_flag = 0;
specialframe = [0 0 1; 1 0 1; 0 0 1];
specialframe2 = [1 0 0; 0 0 1; 0 0 1];
specialframe3 = [0 0 0; 1 0 1; 0 0 1];
specialframe4 = [1 0 0; 0 0 0; 1 0 0];

% another piexel case
% specialpixelframe = [0 1 1; 0 0 1; 0 1 1];
for i=1:length(junctions)
    parent = parentreserve; % Set the original parent so we can get parent in every loop
    endpoint_flag = 0;
    %
    startpoint_flag = flag;
    center = junctions(i);
    skelet = [skelet;center.x center.y]; % Build the skelet based on the coordination of node, one by one
    skelet = unique(skelet,'rows'); % Remove the repeated node in the skelet, since everytime, it will count the centre self
    while(~endpoint_flag) % the loop will not end until there is no coordiantion anymore, and set endpoint = 1.
        downboundx = (center.x-1) ;
        upboundx = (center.x+1);
        downboundy = (center.y-1) ;
        upboundy = (center.y+1) ;
        %%To be consistent with image dimention
        % Problems assign for diemension of image
        if(center.x<=1) %% it was ==
            downboundx = 2;%changed on 4/12/2017 (downboundx+1) ;
            indicator = 0;
        elseif(center.x>=w) %% it was ==
            upboundx = w-1;%changed on 4/12/2017 (downboundx-1) ;
            indicator = 0;
        elseif(center.y<=1) %% it was ==
            downboundy = 2 ;%changed on 4/12/2017 (downboundy+1) ;
            indicator = 0;
        elseif(center.y>=h) %% it was ==
            upboundy = h-1 ;%changed on 4/12/2017 (downboundy-1) ;
            indicator = 0;
        end
        if(isempty(indicator)) % if the bound is outof range, it will not be considered as empty anymore.
            frame = image(downboundx:upboundx,downboundy:upboundy);  %Here the image is not image function, it is for input binary image. And you find 1 in this bound region.
            %find all 1 in frame
            [newpoint.x,newpoint.y] = find(frame==1);  % According the frame to get know what is the next point in region.
            neighbor.x = center.x + (newpoint.x-2);     %%%% Here find the exactly the coordination of neighbor
            neighbor.y = center.y + (newpoint.y-2);     %%%%
            neighbors = [neighbor.x neighbor.y];            %%%%%%%%%%% Make the neighbors as a set.
            %remove center point and points which already stored and find
            %next point for moving the window
            new_neighbors = setdiff(neighbors,intersect(neighbors,skelet,'rows'),'rows');
            [indicator2 junk]= size(new_neighbors);
            temp = zeros(8,1);
            frame(2,2) = 0;
            temp(1) = frame(1,3) - frame(2,3);
            temp(2) = frame(1,2) - frame(1,3);
            temp(3) = frame(1,1) - frame(1,2);
            temp(4) = frame(2,1) - frame(1,1);
            temp(5) = frame(3,1) - frame(2,1);
            temp(6) = frame(3,2) - frame(3,1);
            temp(7) = frame(3,3) - frame(3,2);
            temp(8) = frame(2,2) - frame(3,3);
            indicator = numel(find(temp == -1));
            
            if(startpoint_flag == 0 && indicator == 1)
                indicator = indicator + 1;
                startpoint_flag = 1;
            end
            
            % Special case
            if (isequal(frame, specialframe) || isequal(frame, specialframe2) || isequal(frame, specialframe3))
                indicator = indicator - 1;
            end
            
            if (isequal(frame,specialframe4))
                indicator = indicator + 1;
            end
            
          
            
        end
        if(indicator==1 || indicator==0)%endpoint
            nodetype = 2;%endpoint
            %node(x,y,level,parentxy,type)
            if(~isempty(nodes_cordinates))
                if(isempty(intersect([center.x center.y],nodes_cordinates,'rows')))
                    nodes = [nodes;center.x center.y nodetype parent.level parent.x parent.y ];
%                      viscircles([center.y center.x],1);
                    nodes_cordinates =  [nodes_cordinates;center.x center.y];
                    startpoint_flag = 1;
                end
            else
                nodes = [nodes;center.x center.y nodetype parent.level parent.x parent.y ];
%                  viscircles([center.y center.x],1);
                nodes_cordinates =  [nodes_cordinates;center.x center.y];
                startpoint_flag = 1;
            end
            endpoint_flag = 1;
            skelet = [skelet;center.x center.y];
            %             elseif(indicator==1 && ~startpoint_flag)%startingpoint
            %                 startpoint_flag=1;
            %                 frame(2,2)=0;
            %                 last_center=center;
            %                 [newpoint.x,newpoint.y] = find(frame==1);
            %                 center.x = center.x + (newpoint.x-2);
            %                 center.y = center.y + (newpoint.y-2);
            %                 skelet = [skelet;center.x center.y];
            indicator = [];
        elseif(indicator==2)%usual point
            %                 frame(2+last_center.x-center.x,2+last_center.y-center.y)=0;
            %                 last_center=center;
            %                 [newpoint.x,newpoint.y] = find(frame==1);
            % move window to new position
            if(indicator2 == 3 || indicator2 == 2)
                frame(1,1) = 0; frame(1,3) = 0; frame(3,1) = 0; frame(3,3) = 0;               
                [newpoint.x,newpoint.y] = find(frame==1);
                neighbor.x = center.x + (newpoint.x-2);     %%%% Here find the exactly the coordination of neighbor
                neighbor.y = center.y + (newpoint.y-2);     %%%%
                neighbors = [neighbor.x neighbor.y];            %%%%%%%%%%% Make the neighbors as a set.
                new_neighbors = setdiff(neighbors,intersect(neighbors,skelet,'rows'),'rows');
            end
            if (indicator2 ~= 0)
                center.x = new_neighbors(1,1);
                center.y = new_neighbors(1,2);
                skelet = [skelet;center.x center.y];
                indicator = [];
                startpoint_flag = 1;
            else
                endpoint_flag = 1;
                indicator = [];
                startpoint_flag = 1;
            end
        elseif(indicator>=3)%bifurcation
            nodetype = 1;%bifurcation
            
            if(~isempty(nodes_cordinates))
                if(isempty(intersect([center.x center.y],nodes_cordinates,'rows'))) % We put the cordiantion of center into NODES_CORDINATE if it does not included yet
                    %                     if (isempty(intersect([center.x center.y], nodes(:,1:2),'rows')))
                    nodes = [nodes;center.x center.y nodetype parent.level parent.x parent.y];
%                     viscircles([center.y center.x],1);
                    %                     end
                    nodes_cordinates =  [nodes_cordinates;center.x center.y];
                    startpoint_flag = 1;
                end
                
            else
                %                 if (isempty(intersect([center.x center.y], nodes(:,1:2),'rows')))
                nodes = [nodes;center.x center.y nodetype parent.level parent.x parent.y];
%                 viscircles([center.y center.x],1);
                %                 end    %%% Set every nodes' imformation into a array
                nodes_cordinates =  [nodes_cordinates;center.x center.y];           %%%%%% NODES_CORDINATES just get the cordinations of nodes
                startpoint_flag = 1;
            end
            parent.x = center.x;                %% In the following part, based on the new node to do something above again. Like DPS-searching, it has new parent for now
            parent.y = center.y;
            %                 new_inframe_x =2-(center.x-new_neighbors(:,1));
            %                 new_inframe_y =2-(center.y-new_neighbors(:,2));
            %                 frame(new_inframe_x,new_inframe_y)=0;
            %                 last_center=center;
            %                 [newpoint.x,newpoint.y] = find(frame==1);
            %                 center.x = center.x + (newpoint.x-2);
            %                 center.y = center.y + (newpoint.y-2);
            new_inframe_x =2-(center.x-new_neighbors(:,1));
            new_inframe_y =2-(center.y-new_neighbors(:,2));
            %                 center.x = center.x + (newpoint.x-2);
            %                 center.y = center.y + (newpoint.y-2);
            skelet = [skelet;new_neighbors(:,1) new_neighbors(:,2)];   % It make sense to put the new node into skelet
            skelet = [skelet;center.x center.y];
            for j=1:length(new_inframe_x)
                new_junction(j).x = new_neighbors(j,1);
                new_junction(j).y = new_neighbors(j,2);
            end
            node_search(new_junction,image,parent,1);
            indicator = [];
        end
    end
end
result = nodes;
end