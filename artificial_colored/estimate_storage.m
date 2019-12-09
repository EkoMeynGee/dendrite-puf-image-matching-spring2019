
dt_store = zeros(50,1);

for idx = 1:length(dt_store)
    ff = strcat('c', num2str(idx), '.png');
    fr = imread(ff);
    info = whos('fr');
    dt_store(idx) = info.bytes;
end

%% fetch the stored mat

dt_store_pic_Mat = zeros(50, 1);
for idx = 1: length(dt_store_pic_Mat)
    load('artificial_TreeData')
    eval(['fmat = artificial_TreeData.Tree' num2str(idx) ';'])
    info = whos('fmat');
    dt_store_pic_Mat(idx) = info.bytes;
end
dt_store = [dt_store, dt_store_pic_Mat];
%% noise-stored

for idx = 1: length(dt_store_pic_Mat)
    fn = strcat('c', num2str(idx), '.png');
    fn_rt = imnoise(imread(fn),'gaussian', 0, 0.01);
    sk = colorextract_artificial(fn, 'n');
    sk_rt = colorextract_artificial(fn_rt, 'n');
    circleTest.x = 400;
    circleTest.y = 400;
    circleTest.radius = 36;

    [tree_test, ~, cell_test] = graph_based_rdGen(sk_rt, circleTest);
    info = whos('tree_test');
    dt_store_pic_Mat(idx) = info.bytes;
end
dt_store = [dt_store, dt_store_pic_Mat];

