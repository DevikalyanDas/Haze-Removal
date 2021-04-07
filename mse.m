function    MSE=mymse(x,y)
x=double(x);
y=double(y);
[m n]=size(x);
sumMSE=sum((x(:)-y(:)).^2);
MSE=sumMSE/(m*n);