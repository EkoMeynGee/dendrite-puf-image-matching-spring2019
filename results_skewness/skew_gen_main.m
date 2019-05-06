for index = 1:100
    img = image_projective_4p('b6.png',index);
    eval(['imwrite(img, "sk' num2str(index) '.png");']);
end