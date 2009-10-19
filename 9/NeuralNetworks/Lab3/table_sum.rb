P1 = [ 1,1,1,1,-1,1,1,1,1] 
P2 = [ -1,1,-1,-1,1,-1,-1,1,-1 ] 
P3 = [ -1,-1,-1,1,1,1,-1,-1,-1 ] 

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
for i in (0..8)
	res = 0
	for u in (0..8)
		res = res + w(i,u)*a[u]
	end
	print "#{fact(res)}\t"
end
puts
end

for i in (0..8)
	for u in (0..8)
		print "#{x1(i,u)}\t"
	end
	puts ""
end
puts
for i in (0..8)
	for u in (0..8)
		print "#{x2(i,u)}\t"
	end
	puts ""
end
puts 
for i in (0..8)
	for u in (0..8)
		print "#{w(i,u)}\t"
	end
	puts ""
end
puts
find(P1)
find(P2)
find(P3)
