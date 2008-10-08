I = imread('flowers.tif');
Id = double(I);
[n,m,k] = size(I);
c1 = 0.144;
c2 = 0.256;
c3 = 0.6;
filtr = zeros(2,2);
filtr(1,1:2) = [ -1  , 1 ];
filtr(2,1:2) = [ -1 , 1 ];

[fn,fm] = size(filtr)

Ihalf = zeros(n,m);
for i = 1:n
    for u = 1:m
        Ihalf(i,u) = ( c1 * Id(i,u,1) + c2 * Id(i,u,2) + c3 * Id(i,u,3));
    end
end
IhalfBorder = zeros(n,m);
for i = 1:n-1
    for u = 1:m-1
        nak = 0;
        for i1 = 1:fn
            for u1 = 1:fm
                nak = nak + Ihalf( i + i1 - fn + 1 , u + u1 - fm + 1 ) * filtr(i1,u1);
            end
        end
        IhalfBorder(i,u) = nak;
        if (IhalfBorder(i,u)<0)
            IhalfBorder(i,u) = 0;
        end
    end
end

Iborder_color = zeros(n,m,k);
for i = 1:n - 1
    for u = 1:m -1
        for y = 1:3

            nak = 0;
            for i1 = 1:fn
                for u1 = 1:fm
                    nak = nak + Id( i + i1 - fn + 1 , u + u1 - fm + 1 , y )*filtr(i1,u1);
                end 
            end
            Iborder_color(i,u,y) = nak;
            if (Iborder_color(i,u,y)<0)
                Iborder_color(i,u,y) = 0;
            end
        end
    end
end
Iborder = zeros(n,m);
for i = 1:n
    for u = 1:m
        Iborder(i,u) = (c1*Iborder_color(i,u,1) + c2*Iborder_color(i,u,2) + c3*Iborder_color(i,u,3));
    end
end
clear Id;
clear Iborder_color;
clear filtr;
h = zeros(256);
h2 = zeros(256);
hr = 0;
for i = 1:n
    for u = 1:m
       h( round(Iborder(i,u)) + 1 ) = h( round(Iborder(i,u)) + 1) + 1;
       h2( round(IhalfBorder(i,u))+1 ) = h2( round(IhalfBorder(i,u)) +1) + 1;
       hr = hr + abs(h - h2);
    end
end
hr
figure, subplot(3,2,1), imshow(I), title('image'),
        subplot(3,2,2), imshow(uint8(Ihalf)), title('gray scale'),
        subplot(3,2,3), imshow(uint8(Iborder)), title('from colorful borders'),
        subplot(3,2,4), imshow(uint8(IhalfBorder)), title('from gray scale borders'),
        subplot(3,2,5), plot(h), title('histogram from colorful'),
        subplot(3,2,6), plot(h2), title('histogram from gray scale'),
