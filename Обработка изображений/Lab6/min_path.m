function [a] = min_path(Ifilename, base_dot)
I = imread(Ifilename);
Id = double(I);
[na,m,k] = size(I);
x0 = base_dot(1)
y0 = base_dot(2)
v = zeros( na , m );
a = zeros( na , m );
for i = 1:na
    for u = 1:m
        for y = 1:k
            v(i,u) = a(i,u) + Id(i,u,y);
        end
        v(i,u)/3;
        a(i,u) = (k*255+1);
    end
end
a(x0,y0) = 0;
o = zeros( na*m+1,2 );
o(1,1) = x0;
o(1,2) = y0;
n=1;
k=2;
while (n ~= k)
    x = o(n,1)
    y = o(n,2)
    if ( x > 1 & y > 1 & v( x-1, y-1 ) + a( x , y ) < a( x-1,y-1 )  )
        a( x-1,y-1 ) = v( x-1, y-1 ) + a( x , y );
       o(k,1) = x-1;
       o(k,2) = y-1;
       k = k + 1;
    end
    if ( x > 1 & v( x-1, y ) + a( x , y ) < a( x-1,y )  )
        a( x-1,y ) = v( x-1, y ) + a( x , y ) ;
       o(k,1) = x-1;
       o(k,2) = y;
       k = k + 1;
    end
    if ( x > 1 & y < m & v( x-1, y+1 ) + a( x , y ) < a( x-1,y+1 )  )
        a( x-1,y+1 ) =v( x-1, y+1 ) + a( x , y );
       o(k,1) = x-1;
       o(k,2) = y+1;
       k = k + 1;
    end
    if ( y < m & v( x, y+1 ) + a( x , y ) < a( x,y+1 )  )
        a( x,y+1 ) = v( x, y+1 ) + a( x , y );
       o(k,1) = x;
       o(k,2) = y+1;
       k = k + 1;
    end
    if ( x < na & y < m & v( x+1, y+1 ) + a( x , y ) < a( x+1,y+1 )  )
        a( x+1,y+1 ) = v( x+1, y+1 ) + a( x , y ) ;
       o(k,1) = x+1;
       o(k,2) = y+1;
       k = k + 1;
    end
    if ( x < na & v( x+1, y ) + a( x , y ) < a( x+1,y )  )
        a( x+1,y ) = v( x+1, y ) + a( x , y );
       o(k,1) = x+1;
       o(k,2) = y;
       k = k + 1;
    end
    if ( x < na & y > 1 & v( x+1, y-1 ) + a( x , y ) < a( x+1,y-1 )  )
        a( x+1,y-1 ) = v( x+1, y-1 ) + a( x , y );
       o(k,1) = x+1;
       o(k,2) = y-1;
       k = k + 1;
    end
    if ( y > 1 & v( x, y-1 ) + a( x , y ) < a( x,y-1 )  )
        a( x,y-1 )=v( x, y-1 ) + a( x , y );
       o(k,1) = x;
       o(k,2) = y-1;
       k = k + 1;
    end
    
    n = n + 1;
end
k
a;