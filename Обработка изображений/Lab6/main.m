base_dot = [ 7 , 1 ];
other_dots=[ [8,10] ];
[min_path_m , from_array] = min_path('small.jpg',base_dot);
from_array; 
show_path('small.jpg',from_array,base_dot,other_dots);