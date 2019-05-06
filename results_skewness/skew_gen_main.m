for index = 1:100
    img = image_projective_4p('b3.png',index);
    eval(['name = "s3k' num2str(index) '.png";']);
    name = char(name);
    imwrite(img, name);
end