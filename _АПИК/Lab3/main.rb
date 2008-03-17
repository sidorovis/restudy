
class Array2
    def initialize
	    @store = [[]]
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
end

class Lab1
    attr_reader :col_size, :string_size
    attr_accessor :a,:t,:r
    def initialize(col_size,string_size)
	@col_size, @string_size = col_size, string_size
        @a,@t,@r = Array2.new, Array.new, Array.new
	(1..@string_size).each do |i|
	    (1..@col_size).each do |u|
		@a[i,u] = rand 2 
	    end
	    @t[i],@r[i] = rand(2), rand(2) 
	end
    end
    
    def to_s
	s = "-----------------------------------------------------------\n"
	s += "AM  "
	(1..@col_size).each { |i| s+="#{i} " }
	s += " | t | r\n"
	(1..@string_size).each do |i|
	    s += "    "
	    (1..@col_size).each { |u| s+="#{@a[i,u]} " }
	    s+= " | #{@t[i]} | #{@r[i]}\n"
	end
	return s
    end

end


class Commands

    def initialize(a)
	@l = a
	@params = Array.new
	@command_list = { 			"0)"=> ["выход          ",	0	], 
						"1)"=> ["ноль           ",	0	],
						"2)"=> ["коньюнкция     ", 	2	],
						"3)"=> ["дизьюнкция     ", 	2	],
						"4)"=> ["эквивалентность",	2	],
						"5)"=> ["импикация y->x ",	2	],
						"6)"=> ["импикация x->y ",	2	],
						"7)"=> ["ф-ция Вебба    ",	2	],
						"8)"=> ["штрих Шеффера  ",	2	],
						"9)"=> ["инв.импликации5",	2	],
						"10)"=>["инв.импликации6",	2	],
						"11)"=>["не x           ",	2	],
						"12)"=>["не y           ",	2	],
						"13)"=>["x              ",	2	],
						"14)"=>["y              ",	2	],
						"15)"=>["1              ",	2	],
						"16)"=>["СуммаПоМодулю2 ",	2	],
						"17)"=>["Load R(T)      ",	1	],
						"18)"=>["Load T(T)      ",	1	],
						"19)"=>["Save R(T)      ",	1	],
						"20)"=>["Save T(T)      ",	1	],
						"21)"=>["Enter R	",	0	],
						"22)"=>["Find Fir More	",	1	],
						"23)"=>["Find Fir Small	",	1	]
			}
    end
    def a1
    	(1..@l.string_size).each { |i| @l.r[i] = 0 }
   	end
# 2 arg
    def a2
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] + @l.a[i,@params[2]] == 2 )
    	end
    end
    def a3
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] + @l.a[i,@params[2]] > 0 )
    	end
    end
    def a4
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == @l.a[i,@params[2]])
    	end
    end
    def a5
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 0 && @l.a[i,@params[2]] == 1)
    	end
    end
    def a6
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 1 && @l.a[i,@params[2]] == 0)
    	end
    end
    def a7
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 0 && @l.a[i,@params[2]] == 0)
    	end
    end
    def a8 #sheffer
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 0 || @l.a[i,@params[2]] == 0)
    	end
    end
    def a9
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 1 && @l.a[i,@params[2]] == 0)
    	end
    end
    def a10
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 0 && @l.a[i,@params[2]] == 1)
    	end
    end
 # arg 1
    def a11
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 0 )
    	end
    end
    def a12
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[2]] == 0 )
    	end
    end
    def a13
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] == 1 )
    	end
    end
    def a14
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[2]] == 1 )
    	end
    end
    def a15
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 1
    	end
    end
    def a16
    	(1..@l.string_size).each do |i|
    		@l.r[i] = 0
    		@l.r[i] = 1 if ( @l.a[i,@params[1]] != @l.a[i,@params[2]])
    	end
    end
# other funcs
    def a17 #load r(t)
       	(1..@l.string_size).each do |i|	
    		@l.r[i] = 0 if (@l.t[i] == 1)
    		@l.r[i] = 1 if (@l.t[i] == 1 && @l.a[i,@params[1]] == 1)
    	end

    end
    def a18 #load t(t)
       	(1..@l.string_size).each do |i|	
    		@l.t[i] = 0 if (@l.t[i] == 1 && @l.a[i,@params[1]] == 0)
    		@l.t[i] = 1 if (@l.t[i] == 1 && @l.a[i,@params[1]] == 1)
    	end

    end

    def a19 #save r(t)
       	(1..@l.string_size).each do |i|	
    		@l.a[i,@params[1]] = 0 if (@l.t[i] == 1 && @l.r[i] == 0)
    		@l.a[i,@params[1]] = 1 if (@l.t[i] == 1 && @l.r[i] == 1)
    	end

    end
    def a20 #save t(t)
       	(1..@l.string_size).each do |i|	
    		@l.a[i,@params[1]] = 1 if (@l.t[i] == 1)
    	end
    end
    def a21 #read R
	(1..@l.string_size).each do |i|
		temp = gets
		temp.strip!
		num = temp.to_i
		break if num > 2
		@l.r[i] = num
	end
    end

    def a22 #FIND first bigger than
	users = Array.new
	(1..@l.col_size).each { |i| users[i] = 1 }
	(1..@l.string_size).each { |i| get_bigger_than(users,i) }
    end
    def a23 #FIND first small than
    end
    def to_s
    	s = "Command list: \n"
    	@command_list.sort.each { |f,t| s+="#{f} #{t[0]}\n" }
    	s+= "\n"
    end
    def find(a)
    	return @command_list.has_key? a+")"
    end
	def run(a)
	    a+=")"
	    param_col = @command_list[a][1]
	    puts "Enter params to command '#{@command_list[a][0].strip}'" if 
	    (param_col > 0)
	    (1..param_col).each do |i| 
	    	print "p.#{i} = "
	    	foo = gets
	    	foo.strip!
	    	if (foo.to_i > @l.col_size)
	    		puts " No such column "
	    		return
	 		end
			@params[i] = foo.to_i

	    end
		case a
			when "1)"
				a1;
			when "2)"
				a2;
			when "3)"
				a3;
			when "4)"
				a4;
			when "5)"
				a5;
			when "6)"
				a6;
			when "7)"
				a7;
			when "8)"
				a8;
			when "9)"
				a9;
			when "10)"
				a10;
			when "11)"
				a11;
			when "12)"
				a12;
			when "13)"
				a13;
			when "14)"
				a14;
			when "15)"
				a15;
			when "16)"
				a16;
			when "17)"
				a17;
			when "18)"
				a18;
			when "19)"
				a19;
			when "20)"
				a20;
			when "21)"
				a21;
		end
	end
end

						@string_size = 	9
						@col_size = 	5

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