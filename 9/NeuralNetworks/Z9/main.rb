
$objects = 
[
	[ 4.0 , 6.2 , :A ],
	[ 3.5 , 5.8 , :A ],
	[ 4.0 , 6.0 , :A ],
	[ 4.0 , 5.8 , :A ],
	[ 4.5 , 6.0 , :A ],
	[ 4.5 , 6.5 , :A ],

	[ 6.0 , 6.0 , :B ],
	[ 7.0 , 6.7 , :B ],
	[ 6.0 , 7.0 , :B ],
	[ 7.0 , 7.5 , :B ],
	[ 6.0 , 6.8 , :B ],
	[ 6.5 , 6.0 , :B ],
	[ 6.5 , 6.5 , :B ],
	[ 7.0 , 5.5 , :B ],
	[ 7.0 , 6.0 , :B ],
	[ 8.2 , 6.5 , :B ],
	[ 8.2 , 5.5 , :B ],

	[ 5.2 , 5.8 , :C ],
	[ 5.0 , 4.0 , :C ],
	[ 5.5 , 4.5 , :C ],
	[ 6.0 , 4.0 , :C ],
	[ 5.0 , 3.0 , :C ],
	[ 5.9 , 3.0 , :C ],
	[ 5.0 , 3.0 , :C ],
	[ 6.0 , 3.0 , :C ]
	
]
$object = [ 5.5 , 6.0 , :X ]

$sig = 0.9


def fg(cl)
	summ = 0
	$objects.each do |obj|
		summ += Math::exp( - (pow( obj[0] - $object[0] ) + pow ( obj[0] - $object[0] ))/pow( $sig ) ) if (obj[2] == cl)
	end
	summ
end


def pow(i)
	i*i
end

cur_dist = 99999999
cl1 = :X
$objects.each do |obj|
 c_dist = pow(obj[0]-$object[0])+pow(obj[1]-$object[1])
 if ( c_dist < cur_dist)
	cur_dist = c_dist
	cl1 = obj[2]
 end
end
puts cl1

summ = { :A => [ 0 , 0 , 0 ] , :B => [ 0 , 0 , 0 ] , :C => [ 0 , 0 , 0 ] }
$objects.each do |obj|
	summ[ obj[2] ][2] += 1
	summ[ obj[2] ][0] += obj[0]
	summ[ obj[2] ][1] += obj[1]
end
summ.each { |k,v| (v[0] /= v[2] ; v[1] /= v[2])  }

cur_dist = 99999999
cl2 = :X
summ.each do |k,v|
	c_dist = pow(v[0]-$object[0])+pow(v[1]-$object[1])
	if c_dist < cur_dist
		cur_dist = c_dist
		cl2 = k
	end
end

puts cl2

puts fg(:A)
puts fg(:B)
puts fg(:C)


