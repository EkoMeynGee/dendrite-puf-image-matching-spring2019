function buildDatabase()
%%THis function generallu use original picture to generate dataBase, it
%%will call functions with (old), if you want use this one to generate all
%%data Tree structure, plz remove (old)from each function file name.

% Change the parameter here %%%%%%%%%%IMPORTANT%%%%%%%%%%%%%
 %%%%%%%%%%IMPORTANT%%%%%%%%%%%%%%%%%%%%%%%IMPORTANT%%%%%%%%%%%%%%%%%%%%%%%
numImg = 12;
for index = 1:numImg
    eval(['filename = "b' num2str(index) '.png";']);
    TreeStruct = graph_based(filename);
    eval(['dataBase.Tree' num2str(index) ' = TreeStruct;']);
end

save treeData dataBase;

