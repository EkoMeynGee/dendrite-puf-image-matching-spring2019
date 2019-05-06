function img = image_projective_4p(filename,a)

img1=imread(filename);
[h1,w1]=size(rgb2gray(img1));
mask=uint8(ones(h1,w1));    

img2 = zeros(h1,w1);
[h2,w2]=size(img2);

p1=[1,1;w1,1;1,h1;w1,h1];
p2=[1+a, 1;w1-a, 1; 1+a, h1; w1-a, h1];       

T=calc_homography(p1,p2);   
T=maketform('projective',T);   

[imgn, X, Y]=imtransform(img1,T);     
mask=imtransform(mask,T);

T2=eye(3);
if X(1)>0, T2(3,1)= X(1); end
if Y(1)>0, T2(3,2)= Y(1); end
T2=maketform('affine',T2);     
imgn=imtransform(imgn,T2,'XData',[1 w2],'YData',[1 h2]);    
mask=imtransform(mask,T2,'XData',[1 w2],'YData',[1 h2]);

img2 = im2uint8(img2);
img=img2.*(1-mask)+imgn.*mask;  
imshow(img,[])

