% Title: Solution to Exercise 1
% Name: Yuhang Liang
% Andrew ID: yuhangl

% The following is my solution to Exercise 1
% variables for lab exercise 1
w0=1000;
length=180; % beam length in inches
elasticity=29e6; % elasticity in lb/in^2
inertia=723; % intertial in in^4

% according the question give, we can define a K to simplify the
% coefficients
K = w0/(120*elasticity*inertia*length); % coefficient of the polynomia

y = [-K, 0, K*2*length^2, 0, -K*length^4, 0]; % the present equation

% plot the equation
x = linspace(0, 180, 20); % creates a vector of 20 values
deflection = polyval(y, x); % creates a vector of 20 values of y 
                            % corresponding to the twenty values of x
plot(x, deflection);