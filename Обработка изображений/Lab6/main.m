file_name = 'small.jpg'
I = imread( file_name );

Id = double( I );
[n,m,k] = size( Id );
for i = 1:n
    for u = 1:m
        for y = 1:k
            Id(i,u,y) = Id(i,u,y);%*10*((i)/(255));
            if (Id(i,u,y)>255)
                Id(i,u,y) = 255;
            end
            if (Id(i,u,y)==0)
                Id(i,u,y) = 0;
            end
        end
    end
end
Ir = uint8( Id );

[x,y,vals] = impixel(Ir);
s = size ( x ) - 1;
other_dots = zeros(s+1,2);
for i = 1:s
    other_dots(i,1:2) = [y(i),x(i)];
end
other_dots((s+1):(s+1),1:2) = [y(1),x(1)];

%figure, subplot(2,1,1), imshow(I), title('source'),
%       subplot(2,1,2), imshow(Ir), title('effect');
show_path(Ir,other_dots);