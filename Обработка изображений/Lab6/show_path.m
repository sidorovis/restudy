function [] = show_path(Ifilename, from_array,base_dot,other_dots)
I = imread(Ifilename);
Ic = imread(Ifilename);
x0 = base_dot(1);
y0 = base_dot(2);
[na,m,k] = size(I);
other_dots_size = size(other_dots)
for i = 1:other_dots_size 
    x = other_dots(i,1);
    y = other_dots(i,2);
    while (x ~= x0 || y ~= y0)
        I(x,y,1)=1;
        I(x,y,2)=1;
        I(x,y,3)=1;
        if (from_array(x,y) == 1)
           x = x+1;
           y = y+1;
        elseif (from_array(x,y) == 2)
           x = x+1;
           y = y;
           
        elseif (from_array(x,y) == 3)
           x = x+1;
           y = y-1;
             
        elseif (from_array(x,y) == 4)
           x = x;
           y = y-1;
              
        elseif (from_array(x,y) == 5)
           x = x-1;
           y = y-1;
              
        elseif (from_array(x,y) == 6)
           x = x-1;
           y = y;
              
        elseif (from_array(x,y) == 7)
           x = x-1;
           y = y+1;
              
        elseif (from_array(x,y) == 8)
           x = x;
           y = y+1;
        end    
        x;
        y;
    end
        I(x,y,1)=1;
        I(x,y,2)=1;
        I(x,y,3)=1;
end

figure, subplot(2,1,1), imshow(Ic), title('image');
        subplot(2,1,2), imshow(I), title('way');