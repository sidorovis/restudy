require 'GraphWindow'

class GraphWindow
	def DrawAlgorythm()
		x1 = 1
		y1 = 1
		x2 = 20
		y2 = 15

		x1, x2 = x2, x1 if x1 > x2
		y1, y2 = y2, y1 if y1 > y2

#		DrawADCLine( x1 , y1 , x2 , y2 )
		DrawBrezenhemLine( x1 , y1 , x2 , y2 )
	end
	def DrawLineGeneral(x1,y1,x2,y2)
		dx = x2 - x1
		dy = y2 - y1
		if dx == 0
			(y1..y2).each { |i| DrawDot(x1,i) }
			return true
		end
		if dy == 0
			(x1..x2).each { |i| DrawDot(i,y1) }
			return true
		end
		if dx == dy
			(x1..x2).each { |i| DrawDot(i,y1 + i - x1) }
			return true
		end
		false
	end
	def DrawADCLine(x1,y1,x2,y2)
		return if DrawLineGeneral(x1,y1,x2,y2)
		if dx > dy
			dy /= dx.to_f
			(x1..x2).each { |i| DrawDot( i , (y1 + dy*i + 0.5 ).to_i ) }
		else
			dx /= dy.to_f
			(y1..y2).each { |i| DrawDot((x1 + dx*i + 0.5 ).to_i , i ) }
		end
	end
	def DrawBrezenhemLine(x1,y1,x2,y2)
		return if DrawLineGeneral(x1,y1,x2,y2)
		dx = x2 - x1
		dy = y2 - y1
		if dx > dy
			e = 0
			de = dy
			y = y1
			for x in (x1..x2)
				DrawDot(x,y)
				e += de
				if 2 * e > dx
					y += 1
					e -= dx
				end
			end
		else
			e = 0
			de = dx
			x = x1
			for y in (y1..y2)
				DrawDot(x,y)
				e += de
				if 2 * e > dy
					x += 1
					e -= dy
				end
			end
		end
	end
end
