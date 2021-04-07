function M=wa(I1)
win1=7
s=ones(win1,win1);
sm=1/(win1.^2) .*s;
t1=imfilter(I1,sm,'conv');

% local variance of smmothed image
for i=1:win1
    for j=1:win1
        mo(i,j)=t1(i,j);
        g(i,j)=I1(i,j);
    end
end
% figure(2);
% imshow(g);
for i=1:win1
    for j=1:win1
        vo(i,j)=var(double(mo(:)));
        vg(i,j)=var(double(g(:)));
    end
end

 for i=1:win1
     for j=1:win1
         vn(i,j)=vg(i,j)-vo(i,j);
     end
 end
 
 for i=1:win1
     for j=1:win1
         del(i,j)=vg(i,j)-vn(i,j);
     end
 end
 
 for i=1:win1
    for j=1:win1
        if del(i,j)>0
            eta(i,j)=del(i,j);
        else
            eta(i,j)=0;
        end
    end
 end
 
[temp,originalpos] = sort( del, 'descend' );
n2 = temp(1:3);
max_n1=sum(n2);
k=(1/3).*max_n1;
u=1000/k;

for i=1:win1
    for j=1:win1
        M(i,j)=1/(1+inv(u.*eta(i,j)));
    end
end
end