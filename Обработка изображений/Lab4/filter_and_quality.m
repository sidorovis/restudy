% 21
I = imread('flowers.tif');
Id = double(I);
[n,m,k] = size(I);
filtr =   [ 1 , 1 , 1; 
            1 , 1 , 1;
            1 , 1 , 1];
If = Id;
for i = 2:n-1
    for u = 2:m-1
        for y = 1:k
            nak = 0;
            for i1 = 1:3
                for u1 = 1:3
                    nak = nak + Id( i - 2 + i1 , u - 2 + u1 , y ) * filtr( i1 , u1 );
                end
            end
            If(i,u,y) = nak / 9 ;
            if (If(i,u,y)>255)
                If(i,u,y) = 255;
            end
            if (If(i,u,y)<0)
                If(i,u,y) = 0;
            end
        end
    end
end
xy=0;
x2=0;
y2=0;
for i = 1:n
    for u = 1:m
        for y = 1:3
            xy = xy + Id(i,u,y)*If(i,u,y);
            x2 = x2 + Id(i,u,y)*Id(i,u,y);
            y2 = y2 + If(i,u,y)*If(i,u,y);          
        end
    end
end
Kor = xy / sqrt(x2*y2)

figure, subplot(2,1,1), imshow(I), title('image'),
        subplot(2,1,2), imshow(uint8(If)), title('filter'),
