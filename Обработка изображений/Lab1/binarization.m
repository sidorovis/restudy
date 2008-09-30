I = imread('flowers.tif');
Id = double(I);
Proc = 0.0001;
[n,m,k] = size(I);
%                          building gray scale
Ihalf = zeros(n,m);
for i = 1:n
    for u = 1:m
        Ihalf(i,u) = (Id(i,u,1) + Id(i,u,2) + Id(i,u,3))/3;
    end
end
%                          histograme
g = zeros(256);
gn = zeros(256);
for i = 1:n
    for u = 1:m
        g( Ihalf(i,u)+1 )  = g( Ihalf(i,u)+1 ) + 1;
    end
end
for i = 2:255
      gn( i )  = (g( i )+g( i-1 )+g( i+1 ))/3;
end
border = m*n*Proc
g2T = gn( border:256-border );
T = min( g2T )
I2 = zeros(n,m);
for i = 1:n
    for u = 1:m
        if ( Ihalf(i,u) < T)
            I2(i,u) = 0;
        else
            I2(i,u) = 255;
        end
    end
end

figure, subplot(3,3,1), imshow(I), title('image'),
        subplot(3,3,5), plot(g), title('histograme'),
        subplot(3,3,6), plot(gn), title('normalized histograme'),
        subplot(3,3,4), imshow(uint8(Ihalf)), title('gray scale'),
        subplot(3,3,7), imshow(uint8(I2)), title('binarization');
