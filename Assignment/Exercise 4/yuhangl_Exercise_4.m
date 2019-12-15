% Firstly, we use fsolve to solve this question.
% for this question, we define a=-3 and b=5.
x0 = [5;5];
options = optimoptions('fsolve','Display','off');
[x,Fval,exitflag] = fsolve(@myfun1,x0,options)

% Secondly, we use fzeor to solve this question.
% for this question, we define a=-3 and b=5.
a = -3;
b = 5;
y1 = @(x) -1/(3*x);
y2 = @(x) -x/2;
eqn = @(x) y1(x)-y2(x);
result_x = fzero(eqn,1)
result_y = y1(x)