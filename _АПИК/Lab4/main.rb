require "Array2"
require "Command"

class Lab1

    attr_reader :col_size, :string_size
    attr_accessor :a,:ad,:t,:r
    def initialize(col_size,string_size)
		@col_size, @string_size = col_size, string_size
        @a= Array2.new(col_size,string_size)
        @ad,@t,@r = Array2.new(0,0), Array.new, Array.new
		(1..@string_size).each do |i|
	    	(1..@col_size).each do |u|
				@a[i,u] = rand 2 
	    	end
	    	@t[i],@r[i] = rand(2), rand(2) 
		end
    end
	def create_ad
		a_copy = Array2.new(0,0)
		(1..@string_size).each { |i| (1..@col_size).each { |u| a_copy[i,u],a_copy[i,u+@col_size] = a[i,u],a[i,u] } }
		smesh = @string_size
		(1..@string_size).each do |i|
			(1..@col_size).each do |u|
				ad[u,i] = a_copy[i,u + smesh]
			end
			smesh -= 1
		end
	end
    def to_s
		s =  "--------------------------------------\t-----------------------------------\n"
		s += "AM                                    \tAMD\n"
		create_ad
		(1..@string_size).each do |i|
			s+= " "
			(1..@col_size).each { |u| s = s+ a[i,u].to_s+" " }
			s += "   \t"
			(1..@col_size).each { |u| s = s+ ad[i,u].to_s+" " }
			s += "\n"
		end
		return s
    end

end

						@string_size = 	8
						@col_size = 	8

l = Lab1.new(@string_size,@col_size)

c = Commands.new(l)
command = ""
while true do
    puts l
    puts c
    print " # "
    command = gets
    command.strip!
    break if (command == "0")
    c.run(command) if ( c.find(command) )

end

puts "GoodBye"
