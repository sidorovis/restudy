function [] = waver( Ifilename , wave_c )
I = imread(Ifilename);
Id = double(I);
[n,m,k] = size(I);
If = Id;
for x = 1:n
    for y = 1:m
        for z = 1:k
            o_x = 1 + round( x + 20*sin( 2 * pi * y / wave_c ) );
            o_y = 1 + round( y );
            if o_x > n
                o_x = n;
            end
            if o_y > m
                o_y = m;
            end
            if o_x < 1
                o_x = 1;
            end
            if o_y < 1
                o_y = 1;
            end
            If( x , y , z ) = Id( o_x , o_y , z );
        end
    end
end

figure, subplot(2,1,1), imshow(I), title('image');
        subplot(2,1,2), imshow(uint8(If)), title('waves');
