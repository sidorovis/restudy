D = [ 0,3,6,9,12,1,4,7,10,13,2,5,8,11,14 ]
O = [
[
	[ 0,1,0,
	  1,1,0,
	  0,1,0,
	  0,1,0,
	  1,1, 1
	 ],
	[ 0,0,1]
],
[
	[ 1,1,1,
	  0,0,1,
	  1,1,1,
	  1,0,0,
	  1,1,1
	 ],
	[ 0,1,0]

],
[
	[ 1,1,1,
	  0,0,1,
	  0,1,1,
	  0,0,1,
	  1,1,1
	 ],
	[ 0,1,1]
],
[
	[ 1,1,1,
	  1,0,1,
	  1,0,1,
	  1,0,1,
	  1,1,1
	 ],
	[ 0,1,1]
]
	]
def razd(i)
	return 1 if i == 1
	return -1 if i == 0
end	
	
def m(i,x,y)
	return razd(O[i][0][D[x]]) * razd(O[i][1][y])
end
def w(x,y)
	m(0,x,y)+m(1,x,y)+m(2,x,y)
end

#for i in (0..14)
#	for u in (0..2)
#		print "#{m(0,i,u)}\t"
#		print "#{m(1,i,u)}\t"
#		print "#{m(2,i,u)}\t"
#		print "#{w(i,u)}\t"
#	end
#	puts
#end
#puts
A1 = Array.new(3,0)

for i in (0..14)
	for u in (0..2)
		A1[ u ] = A1[ u ] + razd(O[3][0][D[i]]) * w(i,u) 
	end
end

puts A1

exit
