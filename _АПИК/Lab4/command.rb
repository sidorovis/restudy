
class Commands

    def initialize(a)
	@l = a
	@params = Array.new
	@command_list = { 	"0)"=> ["выход          ",	0	], 
#						"1)"=> ["ноль           ",	0	],
#						"2)"=> ["коньюнкция     ", 	2	],
#						"3)"=> ["дизьюнкция     ", 	2	],
#						"4)"=> ["эквивалентность",	2	],
#						"5)"=> ["импикация y->x ",	2	],
#						"6)"=> ["импикация x->y ",	2	],
#						"7)"=> ["ф-ция Вебба    ",	2	],
#						"8)"=> ["штрих Шеффера  ",	2	],
#						"9)"=> ["инв.импликации5",	2	],
#						"10)"=>["инв.импликации6",	2	],
#						"11)"=>["не x           ",	2	],
#						"12)"=>["не y           ",	2	],
#						"13)"=>["x              ",	2	],
#						"14)"=>["y              ",	2	],
#						"15)"=>["1              ",	2	],
#						"16)"=>["СуммаПоМодулю2 ",	2	],
#						"17)"=>["Load R(T)      ",	1	],
#						"18)"=>["Load T(T)      ",	1	],
#						"19)"=>["Save R(T)      ",	1	],
#						"20)"=>["Save T(T)      ",	1	],
						"21)"=>["Enter R	",	0	],
						"22)"=>["Find Max	",	0	],
						"23)"=>["Find Min	",	0	],
						"24)"=>["Find More R	",	0	],
						"25)"=>["Find Small R	",	0	]
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
private
	def find_biggest( users, string_i )
		return if string_i > @l.string_size
		@l.t[string_i] = 0
		(1..@l.col_size).each { |i| @l.t[string_i] = 1 if users[i] && @l.a[string_i,i] == 1 }
		(1..@l.col_size).each { |i| users[i] = nil if users[i] && @l.a[string_i,i] < @l.t[string_i] }

		find_biggest( users , string_i + 1)
	end
	def find_smallest( users, string_i )
		return if string_i > @l.string_size
		@l.t[string_i] = 1
		(1..@l.col_size).each { |i| @l.t[string_i] = 0 if users[i] && @l.a[string_i,i] == 0 }
		(1..@l.col_size).each { |i| users[i] = nil if users[i] && @l.a[string_i,i] > @l.t[string_i] }

		find_smallest( users , string_i + 1)
	end
	def find_bigger( users , string_i,noque )
		return if string_i > @l.string_size
		(1..@l.col_size).each do |i|
			noque[i] = i if users[i] && @l.a[string_i,i] > @l.r[string_i]
			users[i] = nil if users[i] && @l.a[string_i,i] < @l.r[string_i]
		end
		find_bigger( users , string_i + 1,noque)
	end
	def find_smaller( users , string_i , noque )
		return if string_i > @l.string_size
		(1..@l.col_size).each do |i|
			noque[i] = i if users[i] && @l.a[string_i,i] < @l.r[string_i]
			users[i] = nil if users[i] && @l.a[string_i,i] > @l.r[string_i]
		end
		find_smaller( users , string_i + 1, noque)
	end
public

    def a22 #FIND maximum
		users=Array.new
		(1..@l.col_size).each { |i| users[i] = 1 }
		find_biggest(users,1)
		print " maximals is -> "
		(1..@l.col_size).each { |i| print "  #{i}" if users[i] }
		puts
	end
    def a23 #FIND minimum
		users=Array.new
		(1..@l.col_size).each { |i| users[i] = 1 }
		find_smallest(users,1)
		print " minimals is -> "
		(1..@l.col_size).each { |i| print "  #{i}" if users[i] }
		puts
    end
    def a24 #FIND FIRST MORE THAN R
		users=Array.new
		big=Array.new
		big[@l.col_size] = nil
		(1..@l.col_size).each { |i| users[i] = 1 }
		find_bigger(users,1,big)
		find_smallest(big,1)
		print " bigger than R is -> "
		(1..@l.col_size).each { |i| print "  #{i}" if big[i] }
		puts
    end
    def a25 #FIND FIRST FEW THAN R
		users=Array.new
		small=Array.new
		small[@l.col_size] = nil
		(1..@l.col_size).each { |i| users[i] = 1 }
		find_smaller(users,1,small)
		find_biggest(small,1)
		print " smaller than R is -> "
		(1..@l.col_size).each { |i| print "  #{i}" if small[i] }
		puts
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
			when "22)"
				a22;
			when "23)"
				a23;
			when "24)"
				a24;
			when "25)"
				a25;
		end
	end
end
