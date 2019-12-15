%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
% Name: Yuhang Liang            %
% Andrew ID: yuhangl            %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question1
% a)
% Create a 5x3 matrix of sevens
for i=1:5
    for j=1:3
    question1(i, j) = 7
    end
end
% Replace the second row of the matrix with zeros
question1(2, :) = 0

% b) Replace each element in third row of the matrix 
%    with its corresponding column number squared
for i=1:3
    question1(3, i) = i^2
end

% c) Replace the last column of the updated matrix with 
%    integers starting from 50
for i=1:5
    question1(i, end) = 49+i
end

% Question2
% Generate a image with just the green channel
image1 = imread('test_image.jpg')
imageInGreen = image1
imageInGreen(:,:,1)=0   % set the red channel with zeros
imageInGreen(:,:,3)=0   % set the blue channel with zeros
image(imageInGreen)
% Generate a image with just the red channel
imageInRed = image1
imageInRed(:,:,2) = 0   % set the green channel with zeros
imageInRed(:,:,3) = 0   % set the blue channel with zeros
image(imageInRed)
% Generate a image with just the green channel
imageInBlue = image1
imageInBlue(:,:,2) = 0   % set the green channel with zeros
imageInBlue(:,:,1) = 0   % set the red channel with zeros
image(imageInBlue)

% Question3
imageN = image1
% Get the size of imageN
[m, n] = size(imageN(:,:,2))
for i=1:m
    for j=1:n
        % If the green channel is less than 64, replace
        % the color in this pixel with white
        if imageN(i,j,2)>64
            imageN(i, j, 1) = 255;
            imageN(i, j, 2) = 255;
            imageN(i, j, 3) = 255;
        end
        % If the green channel is greater than 64, replace
        % the color in this pixel with black
        if imageN(i, j, 2)<64
            imageN(i, j, 1) = 0;
            imageN(i, j, 2) = 0;
            imageN(i, j, 3) = 0;
        end
    end
end
image(imageN)

% Question4
image1 = imread('test_image.jpg')
i = 0;
j = 0;
signal = 0
% Check every row
while i<m
    i = i+1;
    j = 0;
    % Check every column
    % For every loop, j starts with 0
    while j<n
        j = j+1
        if image1(i, j, 1)>=50
            image1(i, j, 1) = 0;
            image1(i, j, 2) = 0;
            image1(i, j, 3) = 0;
        else
            signal = 1
            break
        end
    end
    if signal == 1
        break
    end
end
image(image1)