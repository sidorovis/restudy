a = "hello world"
def a.upcases
	gsub(/(.)(.)/) { $1.upcase + $2 }
end

puts a.upcases