% https://www.zhihu.com/question/41120789/answer/1304023183
clear;
x = [10, 2, 1, 7, 3];
y = zeros(length(x), 1);
scatter(x, y);
axis equal;

%% example
clear;
a = [0, 0]';
b = [1, 1]';
a1 = a(1);
b1 = a(2);
a2 = b(1);
b2 = b(2);

e1 = [1, 0]';
e2 = [0, 1]';
e11 = e1(1);
e12 = e1(2);


X1 = a' * e1;
X2 = b' * e1;

left = X1^2 + X2^2;
right = (a1^2 + a2^2)*e11^2 + 2*(a1*b1 + a2*b2)*e11*e12 + (b1^2 + b2^2) * e12^2;

left = X1^2 + X2^2;
P = [a1^2 + a2^2, a1*b1 + a2*b2; a1*b1 + a2*b2, b1^2+b2^2];
right = e1'*P*e1;

[U,Sigma, V] = svd(P);
right = (U' * e1)' * Sigma * (U' * e1);














