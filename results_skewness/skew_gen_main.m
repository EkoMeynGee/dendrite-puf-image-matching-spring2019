for index = 1:2:150
    img = image_projective_4p('./artificial_colored/c45.png',index);
    eval(['name = "./results_skewness/sc45k' num2str(index) '.png";']);
    name = char(name);
    imwrite(img, name);
end