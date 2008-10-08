class Fixnum
    def my_op( b )
    	time = 0
    	a = self

    	first = (a**2 - a*b.abs)
    	time += $t_umn + $t_umn + $t_abs + $t_min + $t_equ
    	return first, time if first > 0

    	time += $t_equ
    	return a**2, time if b == 0

		time += $t_del
    	return a**2 / b, time
    end
end
class Array2
	attr_reader :x, :y
    def initialize( x = 0, y = 0)
	    @store = [[]]
	    @x = x
	    @y = y
    end
    def [](a,b)
	if @store[a] == nil ||
	    @store[a][b] == nil
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
    		(1..@y).each { |u| var += @store[i][u].to_s+"\t" }
    		var += "\n"
    	end
    	var
    end
    def my_op(b)
    	timeN, rang, dnr = 0, 0, 0
    	time1 = 0;
    	rang_sum = 0
    	lsum = 1.0
    	lsredn = 0.0
    	lsrednsredn = 0.0
    	a = self
    	c = Array2.new
    	for i in (1..a.x)
    		for j in (1..b.y)
    			timedop = 0
    			for k in (1..a.y)
    				c[i,j] = 0 unless c[i,j]
    				value , time = a[i,k].my_op( b[k,j] )
    				c[i,j] += value
    				time += $t_sum
    				time1 += time
	   				timedop = time if timedop < time
	   				if (k % $n == 0)
		    			timeN += timedop
		    			rang = $n*4;
		    			rang_sum += rang
 			   		 	lsrednsredn += timedop * rang
		    			timedop = 0
	   				end
    			end
    			timeN += timedop
    			lsum = timeN
    			rang = (a.y % $n) *4
    			lsrednsredn += timedop * rang
    			rang_sum += rang
    		end
 #	   	puts " ... ",Time.new,"     "
    	end
 #   	puts Time.new
    	return c, time1, timeN, rang_sum, lsrednsredn, lsum
    end
end


def ArrayGenerator()
	a, b = Array2.new, Array2.new
	for i in (1..$m)
		(1..$p).each { |u| a[i,u] = rand($max_int) }
	end
	for i in (1..$p)
		(1..$q).each { |u| b[i,u] = rand($max_int) }
	end
	return a, b
end