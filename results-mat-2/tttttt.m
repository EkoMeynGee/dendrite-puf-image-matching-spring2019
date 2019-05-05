ttt = zeros(26,50);

for index = 1:50
    eval(['a = "b' num2str(index) '.tif";']);
    a = char(a);
    ttt(:,index) = abs(noiseTestMain(a, 2));
end
ttt = mean(ttt,2);
