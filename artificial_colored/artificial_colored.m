c.x = 400;
c.y = 400;
c.radius = 35;
for index = 1:50
    eval(['a = artificial_DendriteDic.picRef' num2str(index) ';']);
    a = false_magic(a, c);
    eval(['imwrite(a, "c_other' num2str(index) '.png");']);
end