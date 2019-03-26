for index = 1:50
    eval(['a = artificial_DendriteDic.picRef' num2str(index) ';'])
    a = a*(-1) + 1;
    %imshow(a)    
    eval(['imwrite(a, "b' num2str(index) '.tif");']);
end