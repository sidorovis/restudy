
class Commands

    def initialize(a)
	@l = a
	@params = Array.new
	@command_list = { 	"0)"=> ["выход          ",	0	], 
						"1)"=> ["ноль           ",	[1,2] ],
						"2)"=> ["коньюнкция     ", 	[1,2,1,2,1,2]	],
						"3)"=> ["дизьюнкция     ", 	[1,2,1,2,1,2]	],
						"4)"=> ["эквивалентность",	[1,2,1,2,1,2]	],
						"5)"=> ["импикация y->x ",	[1,2,1,2,1,2]	],
						"6)"=> ["импикация x->y ",	[1,2,1,2,1,2]	],
						"7)"=> ["ф-ция Вебба    ",	[1,2,1,2,1,2]	],
						"8)"=> ["штрих Шеффера  ",	[1,2,1,2,1,2]	],
						"9)"=> ["инв.импликации5",	[1,2,1,2,1,2]	],
						"10)"=>["инв.импликации6",	[1,2,1,2,1,2]	],
						"11)"=>["не x           ",	[1,2,1,2]	],
						"12)"=>["не y           ",	[1,2,1,2]	],
						"13)"=>["x              ",	[1,2,1,2]	],
						"14)"=>["y              ",	[1,2,1,2]	],
						"15)"=>["1              ",	[1,2]	],
						"16)"=>["СуммаПоМодулю2 ",	[1,2,1,2,1,2]	],
						"22)"=>["Find Max	",		[1]	],
						"23)"=>["Find Min	",		[1]	],
#						"24)"=>["Find More R	",	[1,2]	],
#						"25)"=>["Find Small R	",	[1,2]	]
						"26)"=>["RS A+B ifV inS " , [1,2,1] ]
			}
    end
    def get_array(type,number)
    	if type == "string"
    		ans = @l.a.get_string(number)
    	else
    		ans = @l.a.get_column(number)
    	end
    end
    def set_array(type,number , a)
    	if type == "string"
    		ans = @l.a.set_string(number , a)
    	else
    		ans = @l.a.set_column(number , a)
    	end
    end
    def start1
	    @req1 = column
    	@req1 = "string" if @params[0] == 1
		@a1 = get_array(@req1, @params[1])
    end
    def end1
   		set_array(@req1, @params[1] , @a1)
    end
    def a1
    	start1
    	(1..@l.string_size).each { |i| @a1[i] = 0 }
    	end1
   	end
# 2 arg
	def start2
		@req1 = @req3 = @req2 = "column"
    	@req1 = "string" if  @params[0] == 1
		@a1 = get_array(@req1,@params[1])
    	@req2 = "string" if  @params[2] == 1
		@a2 = get_array(@req2,@params[3])
    	@req3 = "string" if  @params[4] == 1
    	@a3 = get_array(@req3,@params[5])
	end
	def end2
   		set_array(@req3, @params[5] , @a3 )
	end
    def a2
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] + @a2[i] == 2 )
    	end
    	end2
    end
    def a3
	    start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] + @a2[i] > 0 )
    	end
    	end2
    end
    def a4
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] == @a1[i])
    	end
    	end2
    end
    def a5
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] == 0 && @a2[i] == 1)
    	end
    	end2
    end
    def a6
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] == 1 && @a2[i] == 0)
    	end
    	end2
    end
    def a7
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] == 0 && @a2[i] == 0)
    	end
    	end2
    end
    def a8 #sheffer
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] == 0 || @a2[i] == 0)
    	end
    	end2
    end
    def a9
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] == 1 && @a2[i] == 0)
    	end
    	end2
    end
    def a10
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] == 0 && @a2[i] == 1)
    	end
    	end2
    end
 # arg 1
	def start15
    	@req1 = "string" if  @params[0] == 1
    	@req1 = "column" if  @params[0] != 1
		@a1 = get_array(@req1,@params[1])
    	@req2 = "column" if  @params[2] != 1
    	@req2 = "string" if  @params[2] == 1
		@a2 = get_array(@req2,@params[3])
	end
	def end15
   		set_array(@req2, @params[3] , @a2 )
	end
 	
    def a11
    	start15
    	(1..@l.string_size).each do |i|
    		@a2[i] = 0
    		@a2[i] = 1 if ( @a1[i] == 0 )
    	end
		end15
    end
    def a12
    	start15
    	(1..@l.string_size).each do |i|
    		@a2[i] = 0
    		@a2[i] = 1 if ( @a1[i] == 0 )
    	end
    	end15
    end
    def a13
    	start15
    	(1..@l.string_size).each do |i|
    		@a2[i] = 0
    		@a2[i] = 1 if ( @a1[i] == 1 )
    	end
    	end15
    end
    def a14
    	start15
    	(1..@l.string_size).each do |i|
    		@a2[i] = 0
    		@a2[i] = 1 if ( @a1[i] == 1 )
    	end
    	end15
    end
    def a15
    	start1
    	(1..@l.string_size).each do |i|
    		@a1[i] = 1
    	end
    	end1
    end
    def a16
    	start2
    	(1..@l.string_size).each do |i|
    		@a3[i] = 0
    		@a3[i] = 1 if ( @a1[i] != @a2[i])
    	end
    	end2
    end
# other funcs
private
	def find_biggest( users, string_i )
		return if string_i > @l.string_size
		if @req1 != "string"
			@l.t[string_i] = 0
			(1..@l.col_size).each { |i| @l.t[string_i] = 1 if users[i] && @l.a[string_i,i] == 1 }
			(1..@l.col_size).each { |i| users[i] = nil if users[i] && @l.a[string_i,i] < @l.t[string_i] }
		else
			@l.t[string_i] = 0
			(1..@l.col_size).each { |i| @l.t[string_i] = 1 if users[i] && @l.a[i,string_i] == 1 }
			(1..@l.col_size).each { |i| users[i] = nil if users[i] && @l.a[i,string_i] < @l.t[string_i] }
		end
		find_biggest( users , string_i + 1)
	end
	def find_smallest( users, string_i )
		return if string_i > @l.string_size

		if @req1 != "string"
			@l.t[string_i] = 1
			(1..@l.col_size).each { |i| @l.t[string_i] = 0 if users[i] && @l.a[string_i,i] == 0 }
			(1..@l.col_size).each { |i| users[i] = nil if users[i] && @l.a[string_i,i] > @l.t[string_i] }
		else
			@l.t[string_i] = 1
			(1..@l.col_size).each { |i| @l.t[string_i] = 0 if users[i] && @l.a[i,string_i] == 0 }
			(1..@l.col_size).each { |i| users[i] = nil if users[i] && @l.a[i,string_i] > @l.t[string_i] }
		end
		find_smallest( users , string_i + 1)
	end
=begin	def find_bigger( users , string_i,noque )
		return if string_i > @l.string_size

		if @req1 != "string"
		(1..@l.col_size).each do |i|
			noque[i] = i if users[i] && @l.a[string_i,i] > @l.r[string_i]
			users[i] = nil if users[i] && @l.a[string_i,i] < @l.r[string_i]
		end
		else
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
=end
public

    def a22 #FIND maximum
    	@req1 = "string" if @params[0] == 1
    	@req1 = "column" if @params[0] != 1
		users=Array.new
		(1..@l.col_size).each { |i| users[i] = 1 }
		find_biggest(users,1)
		print " maximals in #{@req1} is -> "
		(1..@l.col_size).each { |i| print "  #{i}" if users[i] }
		puts
	end
    def a23 #FIND minimum
    	@req1 = "string" if @params[0] == 1
    	@req1 = "column" if @params[0] != 1
		users=Array.new
		(1..@l.col_size).each { |i| users[i] = 1 }
		find_smallest(users,1)
		print " minimals in #{@req1} is -> "
		(1..@l.col_size).each { |i| print "  #{i}" if users[i] }
		puts
    end
=begin
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
=end
	def a26
		puts "Cannot do this on array != 16" if @l.col_size != 16
		return "" if @l.col_size != 16 
		req2 = req1 = "column"
		req1 = "string" if @params[0] == 1
		a1 = get_array(req1,@params[1])
		req2 = "string" if @params[2] == 1
		(1..@l.col_size).each do |i|
			a2 = get_array( req2 , i )
			if (a2[1]==a1[1] && a2[2] == a1[2] && a2[3] == a1[3] && a2[4] == a1[4])
				puts "    changed: #{i}"
				a2[16] = a2[8] + a2[12]
				a2[15] = a2[7] + a2[11]
				a2[14] = a2[6] + a2[10]
				a2[13] = a2[5] + a2[9]
				a2[16],a2[15] = a2[16]-2,a2[15]+1 if a2[16] > 1
				a2[15],a2[14] = a2[15]-2,a2[14]+1 if a2[15] > 1
				a2[14],a2[13] = a2[14]-2,a2[13]+1 if a2[14] > 1
				a2[13] = a2[13]-2 if a2[13] > 1
				set_array( req2 , i , a2 )
			end
		end
	end
    def to_s
    	s = "Command list: \n"
    	a = 1
    	@command_list.sort.each do |f,t| 
    		s+="#{f} #{t[0]}\t\t"
    		a+=1
    		s+="\n" if (a % 3 == 0)
    	end
    	s+= "\n"
    end
    def find(a)
    	return @command_list.has_key? a+")"
    end
	def run(a)
	    a+=")"
	    paramss = @command_list[a][1]
	    param_col = paramss.size
	    puts "Enter params to command '#{@command_list[a][0].strip}'" if (param_col > 0)
	    (0...param_col).each do |i| 
	    	print " type: column-0, string-1: " if paramss[i] == 1
	    	print " column(string) number: " if paramss[i] == 2
	    	foo = gets
	    	foo.strip!
	    	if (foo.to_i > @l.col_size)
	    		puts " No such column"
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
			when "22)"
				a22;
			when "23)"
				a23;
#			when "24)"
#				a24;
#			when "25)"
#				a25;
			when "26)"
				a26;
		end
	end
end
