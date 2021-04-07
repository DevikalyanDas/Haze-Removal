clear all;
close all;
clc;

pkg load signal

pkg load image
dbstop if error
I1=imread('D:\codes_old\Devi\test_img_4.png');
i11=I1;
figure(1);
% set(gcf,'outerposition',get(0,'screensize'));
% subplot(221)
imshow(I1);
title('Given image','Fontsize',20);
imwrite(I1,'D:\codes_old\Devi\Figures\Image4\given_img.png');
[h,w,s]=size(I1);
min_I=zeros(h,w);

w0=0.65;      
t0=0.1;

%darkchannel
for i=1:h                
    for j=1:w
        dark_I(i,j)=min(min(I1(i,j,:)));
    end
end

% subplot(222)
figure(2)
imshow(dark_I);
title('dark channnel','Fontsize',20');
imwrite(dark_I,'D:\codes_old\Devi\Figures\Image4\darkchannel.png');

Max_dark_channel=double(max(max(dark_I)));  
dark_channel=double(dark_I);
t=1-w0*(dark_channel/Max_dark_channel);  

% subplot(223)
figure(3)
T=uint8(t*255);
imshow(T);
title('Transmittance','Fontsize',20);
imwrite(T,'D:\codes_old\Devi\Figures\Image4\transmittance.png');

t=max(t,t0);

% he' method
I1=double(I1);
J(:,:,1) = uint8((I1(:,:,1) - (1-t)*Max_dark_channel)./t);

J(:,:,2) = uint8((I1(:,:,2) - (1-t)*Max_dark_channel)./t);

J(:,:,3) =uint8((I1(:,:,3) - (1-t)*Max_dark_channel)./t);
% subplot(224)
figure(4)
imshow(J);
title('He et al method','Fontsize',20);
imwrite(J,'D:\codes_old\Devi\Figures\Image4\He_et_al.png');

% weight analysis
tic
M=wa(I1);


win=7;

% % % % % % % % % % % % % % % % % % % % %
%  for b1=1:3
kenlRatio = .01;
minAtomsLight = 200;
krnlsz = floor(max([3, w*kenlRatio, h*kenlRatio]))
dc = zeros(h,w);

for y=1:h

    for x=1:w

        dc(y,x) = min(I1(y,x,:));

    end

end
dc2 = maxfilt2(dc, [krnlsz,krnlsz]);

dc2(h,w)=0;

t1 = 255 - dc2;
t_d=double(t1)/255;      
 r = krnlsz*4;
eps = 10^-6;
A = min([minAtomsLight, max(max(dc2))])
tem1=imfilter(t_d,M,'conv');



% filtered = guidedfilter_color(double(img)/255, t_d, r, eps);
filtered = guidedfilter(double(rgb2gray(I1))/255, t_d, r, eps);

td = filtered;
tem2=imfilter(td,tem1,'conv');


img_d=double(I1);
tem2=td;
figure(5),
% subplot(2,2,1),
imshow(i11),title('given image','Fontsize',20);
%imwrite(i11,'D:\codes_old\Devi\Figures\Image4\given_img_5.png');

% subplot(2,2,2),
figure(6)
imshow(tem1,[]),title('using wa','Fontsize',20);
%imwrite(tem1,'D:\codes_old\Devi\Figures\Image4\wa.png');

% subplot(2,2,3),
figure(7)
imshow(tem2,[]),title('filtered transmittance','Fontsize',20);
imwrite(tem2,'D:\codes_old\Devi\Figures\Image4\filtered_transmittance.png');

F(:,:,1) = (img_d(:,:,1) - (1-td).*A)./td;

F(:,:,2) = (img_d(:,:,2) - (1-td).*A)./td;

F(:,:,3) = (img_d(:,:,3) - (1-td).*A)./td;
%



% subplot(2,2,4),
figure(8)
imshow(uint8(F)),title('final op','Fontsize',20);
imwrite(uint8(F),'D:\codes_old\Devi\Figures\Image4\final_op.png');

figure(5)
% subplot(1,3,1),
figure(9)
imshow(uint8(I1));title('given image','Fontsize',20);
%imwrite(uint8(I1),'D:\codes_old\Devi\Figures\Image4\given_img_9.png');

% subplot(1,3,2),
figure(10)
imshow(J);title('He et al method','Fontsize',20);
imwrite(J,'D:\codes_old\Devi\Figures\Image4\He_et_al_method.png');

% subplot(1,3,3),
figure(11)
imshow(uint8(F));title('using wa','Fontsize',20);
imwrite(uint8(F),'D:\codes_old\Devi\Figures\Image4\using_wa.png');
toc
%----------------------------------
%imwrite(uint8(J), ['_', image_name])  
       
% mae1=meanAbsoluteError(J,I1);
% mae2=meanAbsoluteError(uint8(F),I1);
% disp(mae1)
% disp(mae2)
%
 [mse1,rmse1]=RMSE2(I1,J);
 [mse2,rmse2]=RMSE2(I1,uint8(F));
 disp(mse1)
 disp(mse2)
 
 mae1=meanAbsoluteError(I1,J);
 mae2=meanAbsoluteError(I1,uint8(F));
 disp(mae1)
 disp(mae2)

PSNR1=psnr(J,I1);
PS=psnr(I1,uint8(F));
disp(PSNR1)
disp(PS)

figure(12)
% hold on
% bar([PS PSNR1],0.7),title('PSNR'),
% legend('He et al','using WA');
% hold off
%
% figure(7)
% hold on
% bar([mse2;mse1],0.7),title('MSE'),
% legend('He et al','using WA');
% hold off
%
% figure(8)
% hold on
% bar(rmse2,'g'),
% bar(rmse1,'r'),
% title('RMSE'),
% legend('He et al','using WA');
%
% hold off
bar([PS PSNR1;mse2 mse1;mae2 mae1]);
xticklabels({'PSNR','MSE','MAE'})
legend('He et al','using WA','Location','NorthEastOutside');
saveas(gcf,'example.jpg')
%exportgraphics(gcf, 'D:\codes_old\Devi\Figures\Image4\img_12.png', 'Resolution', 100)






