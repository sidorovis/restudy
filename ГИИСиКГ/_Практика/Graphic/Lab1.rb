require 'GraphWindow'

class GraphWindow
	def DrawAlgorythm()
		x1,y1,x2,y2 = 3 , 5 , 8 , 10

#		DrawADCLine( x1 , y1 , x2 , y2 )
		DrawBrezenhemLine( x1 , y1 , x2 , y2 )
	end
	def DrawLineGeneral(x1,y1,x2,y2)
		dx, dy, dop = x2 - x1, y2 - y1, 1
		if dx == 0
			x1, y1, x2, y2 = x2, y2, x1, y1 if y1 > y2		
			(y1..y2).each { |i| DrawDot(x1,i) }
			return true
		end
		if dy == 0
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2		
			(x1..x2).each { |i| DrawDot(i,y1) }
			return true
		end
		if dx.abs == dy.abs
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2
			dop = -1 if ( y1 > y2)
			(x1..x2).each { |i| DrawDot(i, y1 + (i - x1)*dop ) }
			return true
		end
		false
	end
	def DrawADCLine(x1,y1,x2,y2)
		return if DrawLineGeneral(x1,y1,x2,y2)
		dx, dy = x2 - x1, y2 - y1
		if dx.abs > dy.abs
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2		
			dy /= dx.to_f
			(x1..x2).each { |i| DrawDot( i , (y1 + dy*i + 0.5 ).to_i ) }
		else
			x1, y1, x2, y2 = x2, y2, x1, y1 if y1 > y2		
			dx /= dy.to_f
			(y1..y2).each { |i| DrawDot((x1 + dx*i + 0.5 ).to_i , i ) }
		end
	end
	def DrawBrezenhemLine(x1,y1,x2,y2)
		return if DrawLineGeneral(x1,y1,x2,y2)
		dop, dx, dy = 1, x2 - x1, y2 - y1
		if dx.abs > dy.abs
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2
			dop *= -1 if y2 - y1 < 0
			e, de, y = 0, dy.abs, y1
			for x in (x1..x2)
				DrawDot(x,y)
				e += de
				y, e = y + dop, e - dx.abs if 2 * e > dx.abs
				print "x= #{x}, y= #{y} \n"
			end
		else
			x1, y1, x2, y2 = x2, y2, x1, y1 if y1 > y2
			dop *= -1 if x2 - x1 < 0
			e, de, x = 0, dx.abs, x1
			for y in (y1..y2)
				DrawDot(x,y)
				e += de
				x, e = x + dop, e - dy.abs if 2 * e > dy.abs
				print "x= #{x}, y= #{y}, e= #{e} \n"
			end
		end
	end
end
