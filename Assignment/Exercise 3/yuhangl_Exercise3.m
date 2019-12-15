%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
% Name: Yuhang Liang            %
% Andrew ID: yuhangl            %
% Course Number: 12-659         %
% Assignment: Exercise 3        %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Question 1
% Read the values in the csv file into a matrix, M
M = csvread('exercise3.csv')

% Question 2
% Find the number of rows and columns in the matrix, M
[rows, cols] = size(M)
disp(['The column of M is ', num2str(rows)])
disp(['The row of M is ', num2str(cols)])

% Question 3
% Display the original matrix, the inverse matrix and the verification
invOfM = inv(M)
disp('The original matrix is ')
disp(M)
disp('The inverse matrix is ')
disp(invOfM)
disp('The product of two matrixs is ')
disp(M*invOfM)
disp('Therefore, they are inversed to each other.')

% Question 4
% Write the inverse matrix to a new csv file
csvwrite('yuhangl3inv.csv', invOfM)

% Question 5
% The dot product of the second row with the third row 
% (the inverse matrix)
disp('The corresponding product of the inverse matrixs is ')
invOfM(2,:).*invOfM(3,:)
% The dot product of the second row with the third row 
% (the original matrix) 
disp('The corresponding product of the original matrixs is ')
M(2,:).*M(3,:)

% Question 6
% Round each number in the M matrix to the nearest integer
roundedM = round(M)
% Take its absolute value
absRoundedM = abs(roundedM)
% Convert it to its ascii character
charOfabsRoundedM = char(absRoundedM)
disp(charOfabsRoundedM)