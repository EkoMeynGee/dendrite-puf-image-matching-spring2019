deg = zeros(100,1);
for index = 1:100
    deg(index) = rad2deg(acos((386-index)/386));
end