deg = zeros(150,1);
for index = 1:2:150
    deg(index) = rad2deg(acos((386-index)/386));
end