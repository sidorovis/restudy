%I= imread('im.png');
I= imread('moto_0057.jpg');
border = 100;
small = 0;
big = 255;

I2 = I;
I3 = double( I );
I3 = I3 * 0.3;
I4 = uint8( I3 );
I2 (I2 > border) = big;
I2 (I2 < border) = small;
I5 = I;
I5(30:60, 100:120, 2) = 255;
[m,n] = size(I5);
I5(1:90,:) = rand(90,n)*150
I6 = double(I);

for i = 2:m-1
    for u = 2:n-1
        I8 = [];
        I8(1) = I6(i - 1,u - 1);
        I8(2) = I6(i - 1,u );
        I8(3) = I6(i - 1,u + 1);
        I8(4) = I6(i ,u - 1);

        I8(5) = I6(i ,u +1);
        I8(6) = I6(i + 1,u - 1);
        I8(7) = I6(i + 1,u );
        I8(8) = I6(i + 1,u + 1);

        I9 = sort(I8);
        
        I6(i,u) = I9(4);
    end
end
I7 = uint8( I6 );

figure, 
subplot(1,5,1), imshow(I),  title('source'),
subplot(1,5,2), imshow(I2), title('binarization'),
subplot(1,5,3), imshow(I4), title(' * 0.3 '),
subplot(1,5,4), imshow(I5), title('randomization on part'),
subplot(1,5,5), imshow(I7), title('mediation filter');

