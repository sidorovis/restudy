function [a,from] = min_path(I,base_dot)
Id = double(I);
[na,m,k] = size(I);
c = round(na*m / 100);
x0 = base_dot(1);
y0 = base_dot(2);
v = zeros( na , m );
a = zeros( na , m );
from = zeros( na , m );
for i = 1:na
    for u = 1:m
        for y = 1:3
            v(i,u) = v(i,u) + Id(i,u,y);
        end
        v(i,u) = v(i,u) / 3;
        a(i,u) = (na*m*k*255+1);
        from(i,u)=-1;
    end
end
a(x0,y0) = 0;
o = zeros( na*m*k*3+1,2 );
o(1,1) = x0;
o(1,2) = y0;
n=1;
k=2;
 while (n < k)
    x = o(n,1);
    y = o(n,2);
    vt = v(x,y);
    vt = 0;
    at = a(x,y);
    if ( x > 1 & y > 1 & (sqrt(2)*abs(v( x-1, y-1 )-vt) + at < a( x-1,y-1 ))  )
       a( x-1,y-1 ) = sqrt(2)*abs(v( x-1, y-1 )-vt) + at;
       o(k,1:2) = [x-1,y-1];
       from(x-1,y-1) = 1;
       k = k + 1;
    end
    if ( x > 1 & abs(v( x-1, y )-vt) + at < a( x-1,y )  )
       a( x-1,y ) = abs(v( x-1, y )-vt) + at ;
       o(k,1:2) = [x-1,y];
       from(x-1,y) = 2;
       k = k + 1;
    end
    if ( x > 1 & y < m & ((sqrt(2)*abs(v( x-1, y+1 )-vt) + at) < a( x-1,y+1 ))  )
        a( x-1,y+1 ) =sqrt(2)*abs(v( x-1, y+1 )-vt) + at;
       o(k,1:2) = [x-1,y+1];
       from(x-1,y+1) = 3;
       k = k + 1;
    end
    if ( y < m & (abs(v( x, y+1 )-vt) + at) < a( x,y+1 )  )
        a( x,y+1 ) = abs(v( x, y+1 )-vt) + at;
       o(k,1:2) = [x,y+1];
       from(x,y+1) = 4;
       k = k + 1;
    end
    if ( x < na & y < m & ((sqrt(2)*abs(v( x+1, y+1 )-vt) + at) < a( x+1,y+1 ))  )
        a( x+1,y+1 ) = sqrt(2)*abs(v( x+1, y+1 )-vt) + at ;
       o(k,1:2) = [x+1,y+1];
       from(x+1,y+1) = 5;
       k = k + 1;
    end
    if ( x < na & (abs(v( x+1, y )-vt) + at) < a( x+1,y )  )
        a( x+1,y ) = abs(v( x+1, y )-vt) + at;
       o(k,1:2) = [x+1,y];
       from(x+1,y) = 6;
       k = k + 1;
    end
    if ( x < na & y > 1 & ((sqrt(2)*abs(v( x+1, y-1 )-vt) + at) < a( x+1,y-1 ))  )
        a( x+1,y-1 ) = sqrt(2)*abs(v( x+1, y-1 )-vt) + at;
       o(k,1:2) = [x+1,y-1];
       from(x+1,y-1) = 7;
       k = k + 1;
    end
    if ( y > 1 & ((abs(v( x, y-1 )-vt) + at) < a( x,y-1 ))  )
        a( x,y-1 )=abs(v( x, y-1 )-vt) + at;
       o(k,1:2) = [x,y-1];
       from(x,y-1) = 8;
       k = k + 1;
    end
    n = n + 1;  
end
a;