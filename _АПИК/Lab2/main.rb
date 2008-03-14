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
		"\t#{@slovo}\t| #{colizies}\t| #{free}\t| #{datas_link}\n"
	end

	def Titles
		"-------\t-------\t\t------\t-------\t-----------\n"+
		"HashKey\t| ID   \t\t| Cols\t| Free?\t| Link2Data\n"
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
			if @cells.slovo == key_str
				if @cells[ hash_key ].datas_link 
				    replace = @cells[ hash_key ].datas_link 
					puts " #{hash_key} value (#{@cells[ hash_key].slovo}) have colizion that we shall change"
					cell = @cells[ replace ]
					@cells[hash_key] = cell
					@cells.delete( replace )

				else
					@cells.delete hash_key
					puts " #{hash_key} value (#{@cells[ hash_key].slovo}) deleted"
				end
			else
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

while command != "quit"
	print "\n\nCommand list: quit, insert, show, delete: \n command # "
	command = gets
	command.strip!
	if command == "insert"
		print " fio # "
		fio = gets
		print " datas # "
		datas = gets
		table.insert_datas( fio.strip, datas.strip )
	end
	if command == "show"
		print table
	end
	if command == "delete"
		print " fio # "
		fio = gets
		table.delete_datas( fio.strip )
	end
end
