def openFile()
	unless File.exist?("rules.rer")
		puts "no rules file"
	else
		f = File.open("rules.rer","r")
		until f.eof?
			str = f.getc
			puts (str.methods).sort
			puts "","",str.display,"",""
#			puts str.chr
		end
	end
end


openFile()

