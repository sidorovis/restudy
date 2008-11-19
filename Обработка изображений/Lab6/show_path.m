function [] = show_path(I, other_dots)
way_color = [1,1,1];
Ic = I;
[na,m,k] = size(I);
other_dots_size = size(other_dots)
for i = 2:other_dots_size 
    x0 = other_dots(i-1,1);
    y0 = other_dots(i-1,2);
    base_dot = [x0, y0];
    [min_path_m , from_array] = min_path(Ic,base_dot);    
    x = other_dots(i,1);
    y = other_dots(i,2);
    while (x ~= x0 || y ~= y0)
        I(x,y,1:3)=way_color;
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
        I(x,y,1:3)=way_color;
end

figure, subplot(2,1,1), imshow(Ic), title('image');
        subplot(2,1,2), imshow(I), title('way');