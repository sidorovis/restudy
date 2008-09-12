Dir.foreach(Dir.getwd) do |x|
	if x =~ /.*ui$/
		`rbuic4 -x -o #{x}.rb #{x}`
	end
end
