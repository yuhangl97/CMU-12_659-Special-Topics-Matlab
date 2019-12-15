%question1
for i=1:5
    for j=1:3
        A(i,j)=7
    end
end
%a
for j=1:3
    A(2,j)=0
end
%b
for j=1:3
    A(3,j)=j^2
end
%c
for i=1:5
    A(i,3)=49+i
end
%question2
image=imread('test_image.jpg');
imagewithred=image;
imagewithred(:,:,2)=0;
imagewithred(:,:,3)=0;
imshow(imagewithred);
%
image=imread('test_image.jpg');
imagewithgreen=image;
imagewithgreen(:,:,1)=0;
imagewithgreen(:,:,3)=0;
imshow(imagewithgreen);
%
image=imread('test_image.jpg');
imagewithblue=image;
imagewithblue(:,:,1)=0;
imagewithblue(:,:,2)=0;
imshow(imagewithblue);
%question3
image=imread('test_image.jpg')
[m,n]=size(image(:,:,2))
for i=1:m
    for j=1:n
        if image(i,j,2)>64
            image(:,:,1)=255
            image(:,:,2)=255
            image(:,:,3)=255
        end
        if image(i,j,2)<64
            image(:,:,1)=0
            image(:,:,2)=0
            image(:,:,3)=0
        end
    end
end
%question4
image = imread('test_image.jpg')
i = 0;
j = 0;
signal = 0
while i<m
    i = i+1;
    j = 0;
    while j<n
        j = j+1
        if image(i, j, 1)>=50
            image(i, j, 1) = 0;
            image(i, j, 2) = 0;
            image(i, j, 3) = 0;
        else
            signal = 1
            break
        end
    end
    if signal == 1
        break
    end
end
imshow(image)