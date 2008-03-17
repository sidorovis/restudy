class Cell
	attr_accessor :slovo, :colizies, :free, :datas_link, :datas
	def initialize(slovo,datas)
		@slovo = slovo
		@colizies = false
		@free = false
		@datas_link = nil
		@datas = datas
	end
	def to_s
		conn = false
		conn = true if @datas_link
		sl = @slovo
		sl += "     " if sl.length < 6
		"#{sl}\t| #{@colizies}\t| #{conn}\t| #{@free}\t| #{@datas_link}\t| #{@datas}\n"
	end

	def Titles
		"-------\t|------\t-----\t|-----\t|------\t|------\t|----\t|------\n"+
		"HashKey\t| ID   \t\t| Cols\t| Conn?\t| Free?\t| L2D\t| Datas\n"
	end
end

class Table

	def initialize( )
		@hash_key = 					26
		@hash_len = 2
		@cells = Array.new
	end
	def str_size()
		@cells.length
	end
	def insert_datas(key_str, data_str)	
		if key_str.length < @hash_len
			puts " FIO to small"
			return
		end
		hash_key = hash_string(key_str, @hash_len )
		if !@cells[hash_key] 
			new_cell = Cell.new(key_str,data_str)
			@cells[hash_key] = new_cell
			puts " -> datas inserted. place(key   ): #{hash_key}\t, value: #{new_cell}"
		else
			if @cells[hash_key].slovo == key_str
				@cells[hash_key].datas = data_str
				puts "-> changind datas in #{key_str} (#{hash_key})"
			else
				address = @cells[hash_key].datas_link
				old_address = hash_key
				while address && @cells[address].slovo != key_str
					old_address = address
					address = @cells[ address ].datas_link
				end
				if !address
					cell = 0
					while @cells[ cell ] && @cells[ cell ].slovo != key_str
						cell += 1
					end
					new_cell = Cell.new(key_str,data_str)
					@cells[ cell ] = new_cell
					@cells[ old_address ].datas_link = cell
					@cells[ old_address ].colizies = true
					puts " -> datas inserted. place(search): #{cell}\t, value: #{new_cell}; cell #{@cells[ old_address ].slovo} with #{old_address} change data_link to #{cell}"
				else
					@cells[ address ].datas = data_str;
				puts "-> changind datas in #{@cells[address].slovo} (#{address})"
	
				end
			end
		end
	end		
	def delete_datas( key_str )
		if key_str.length < @hash_len
			puts " FIO to small"
			return
		end

		hash_key = hash_string( key_str , @hash_len )
		if @cells[ hash_key ]
			key = hash_key
			while key && @cells[ key ] && @cells[ key ].slovo != key_str do
				old_key = key
				key = @cells[ key].datas_link
			end
			if @cells[ key ].slovo == key_str
				if @cells[ key ].datas_link 
				    replace = @cells[ key ].datas_link 
					puts " #{key} value (#{@cells[ key ].slovo}) have colizion that we shall change"
					cell = @cells[ replace ]
					@cells[ key ] = cell
					@cells.delete_at( replace )
					@cells.insert( replace , nil )
				else
					if @cells[ old_key ] && @cells[ old_key ].datas_link == key
						@cells[ old_key ].colizies = false
						@cells[ old_key ].datas_link = nil
					end
					cell = @cells[ key ]
					@cells.delete_at key
					@cells.insert( key , nil )
					puts " #{key} value (#{cell.slovo}) deleted"
				end
			else
				puts " -> #{key_str} not exist"
			end
		else		
			puts " -> #{key_str} not exist"
		end
	end
	def to_s
		answer = Cell.new("","").Titles
		(0..@cells.length).each { |i| answer += i.to_s+"\t| " +@cells[i].to_s if @cells[i] }
		answer
	end
	def find ( key_str )
		hash_key = hash_string( key_str , @hash_len )
		if @cells[ hash_key ]
			key = hash_key
			while key && @cells[ key ] && @cells[ key ].slovo != key_str do
				old_key = key
				key = @cells[ key ].datas_link
			end
			if key && @cells[ key ].slovo == key_str
				puts " we find: #{@cells[ key ].datas}"
			else
				puts " No such string"
			end
		else
			puts " No such string"
		end

	end
private
	def hash_string(str,k)
		answer = 0
		(0...k).each do |i|
			l = relocate_letter( str[i] )
			answer = answer + @hash_key**(k-i-1)*l
		end
		answer
	end
	def relocate_letter(l)
		if l >= 65 && l <= 90
			l -= 65 
		else
			l -= 71
		end
	end

end

table = Table.new

command = ""

table.insert_datas("asdh","dsa3")
table.insert_datas("asdf","dsa4")
table.insert_datas("asdfg","ds5a")
table.insert_datas("hello","another constr key");
table.insert_datas("hilary","klinton");
table.insert_datas("asd","dsa1")
table.insert_datas("another","key");
table.insert_datas("asde","dsa2")
table.insert_datas("comprasion","key_value");
print table

while command != "quit" && command != "q"
	print "\n\nCommand list: find, quit, add, set, show, del: \n command # "
	command = gets
	command.strip!
	if command == "add" || command == "set" then
		print " fio # "
		fio = gets
		print " datas # "
		datas = gets
		table.insert_datas( fio.strip, datas.strip )
	end
	if "show" == command then
		print table
	end
	if "del" == command then
		print " fio # "
		fio = gets
		table.delete_datas( fio.strip )
	end
	if "find" == command then
		print " fio # "
		fio = gets
		table.find( fio.strip )
	end
end