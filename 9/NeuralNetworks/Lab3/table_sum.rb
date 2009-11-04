P1 = [ -1, 1,-1,-1, 1,-1,-1, 1 ]
P2 = [ -1,-1, 1,-1,-1,-1, 1,-1 ]

P3 = [ -1, 1,-1,-1, 1,-1,-1, 1 ]
P4 = [ -1, 1, 1,-1, 1,-1,-1,-1 ]

SIZE= P1.size - 1

#P1 = [ 1,1,1,1,-1,1,1,1,1] 
#P2 = [ -1,1,-1,-1,1,-1,-1,1,-1 ] 
#P3 = [ -1,-1,-1,1,1,1,-1,-1,-1 ] 

def x1(x,y)
	return 0 if x == y
	return P1[x]*P1[y]
end
def x2(x,y)
	return 0 if x == y
	return P2[x]*P2[y]
end

def w(x,y)
	x1(x,y)+x2(x,y)
end

def fact(x)
	return 1 if (x > 0)
	return -1 if (x < 0)
	return 0
end

def find(a)
puts 
for i in (0..SIZE)
	res = 0
	for u in (0..SIZE)
		res = res + w(i,u)*a[u]
	end
	print "#{fact(res)}\t"
end
puts
end

for i in (0..SIZE)
	for u in (0..SIZE)
		print "#{x1(i,u)}\t"
	end
	puts ""
end
puts
for i in (0..SIZE)
	for u in (0..SIZE)
		print "#{x2(i,u)}\t"
	end
	puts ""
end
puts 
for i in (0..SIZE)
	for u in (0..SIZE)
		print "#{w(i,u)}\t"
	end
	puts ""
end
puts
find(P1)
find(P2)
find(P3)
find(P4)
#find(P3)
