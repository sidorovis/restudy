class Array2
	attr_reader :x, :y
    def initialize( x = 0, y = 0)
	    @store = [[]]
	    @x = x
	    @y = y
    end
    def [](a,b)
	if @store[a] == nil || @store[a][b] == nil
		return 0 if a <= @x && b <= @y
		return nil
	else
	    return @store[a][b]
	end
    end
    def []=(a,b,x)
   	@x = a if a > @x
   	@y = b if b > @y
	@store[a] = [] if @store[a] == nil
	@store[a][b] = x
    end
    def to_s
    	var = "";
    	for i in (1..@x)
    		(1..@y).each { |u| var += "'"+@store[i][u].to_s+"'\t" }
    		var += "\n"
    	end
    	var
    end
    def size
    	return @x, @y
    end
    def *(b)
    	return nil unless b
    	a = self
    	c = Array2.new
    	return nil if a.y != b.x
    	for i in (1..a.x)
    		for j in (1..b.y)
   				c[i,j] = 0 unless c[i,j]
    			for k in (1..a.y)
    				c[i,j] += a[i,k]*b[k,j];
    			end
    		end
    	end
    	return c
    end
end
