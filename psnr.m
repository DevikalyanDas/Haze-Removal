%�����ֵ�����
%xΪԭʼͼ��
%yΪ���ͼ��
function psnr=psnr(x,y)
x=double(x);
y=double(y);
[m n l]=size(x);
cs1=n*m*l*255*255;
cd1=sum((x(:)-y(:)).^2);
psnr=10*log10(cs1/cd1);