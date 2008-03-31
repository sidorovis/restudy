
class Array2
    def initialize(s,c)
	    @store = [[]]
	    @s,@c = s,c
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
		@store[a] = [] if @store[a] == nil
		@store[a][b] = x
    end
    def get_string(index)
    	a = Array.new
    	(1..@s).each { |i| a[i] = @store[index][i] }
    	a
    end
    def get_column(index)
    	a = Array.new
    	(1..@c).each { |i| a[i] = @store[i][index] }
    	a
    end
    def set_string(index,a)
    	(1..@s).each { |i| @store[index][i] = a[i] }
    end
    def set_column(index,a)
    	(1..@c).each { |i| @store[i][index] = a[i] }
    	a
    end
end
