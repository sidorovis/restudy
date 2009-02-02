require 'Lab5'

class GraphWindow

	slots 'FrameMode()', 'NoFrameMode()', 'justDrawFrame()'

	alias :old6_connectActions :connectActions
	alias :old2_DrawAlgorythm :DrawAlgorythm
	alias :old2_addedKeyReleaseEvent :addedKeyReleaseEvent

=begin
	function lengthOfVector(x,y)
		input x,y : double value
		output length of vector (x,y)
				calculate length of vector
=end
def lengthOfVector(x,y)
	return ( ((1.0*x)**2)+((1.0*y)**2) )**0.5
end
=begin
	function crossDotByParams(a1,b1,c1,a2,b2,c2)
		input a1,b1,c1,a2,b2,c2 : double value
		output xp,yp dot of line crossing
				calculate cross dot to 2 lines: a1,b1,c1 <-> a2,b2,c2
=end
	def crossDotByParams(a1,b1,c1,a2,b2,c2)
		x = (b1*c2-b2*c1)/(a1*b2-a2*b1)
		y = (c1*a2-c2*a1)/(a1*b2-a2*b1)
		return x, y
	end
=begin
	function makeLineParams(x1,y1,x2,y2)
		input x1,y1,x2,y2 : double value
		output a,b,c
				calculate a,b,c parameters of line
=end
	def makeLineParams(x1,y1,x2,y2)
		a = 1.0*y2-1.0*y1
		b = 1.0*x1-1.0*x2
		c = -1.0*a*x1-1.0*b*y1
		return a,b,c
	end
	
	def addedKeyReleaseEvent(e)
		old2_addedKeyReleaseEvent(e)
#		puts e.key
		return unless @@frame
		@@frame[0] -=1 if e.key == 67	# b
		@@frame[1] +=1 if e.key == 70	# h
		@@frame[1] -=1 if e.key == 86	# n
		@@frame[0] +=1 if e.key == 66	# m
	end

=begin
	функция FrameDrawAlgorythm генерирует фрейм
=end
	def FrameDrawAlgorythm
		for i in @frame
			l = [ [i[0][0],i[0][1]],[i[1][0],i[1][1]] ]
			l[0][0] += @@frame[0]
			l[0][1] += @@frame[1]
			l[1][0] += @@frame[0]
			l[1][1] += @@frame[1]
			justDrawADCLine(l)
		end
	end
=begin
	функция findP ищет точки пересечения и проверяет цвет с которого начинать закраску
		входные параметры:
			i координаты прямой которую проверяем на вхождение в экран
		выходные параметры:
			массив точек прямых которые требуется отрисовать
			метка показывающая цвет с которого требуется начать отрисовку
=end
	def findP( i )
		a = []
		x3,y3,x4,y4 = i[0][0], i[0][1], i[1][0], i[1][1]
		a2,b2,c2 = makeLineParams(x3,y3,x4,y4)
		for i in @frame
			x1,y1,x2,y2 = i[0][0]+@@frame[0],i[0][1]+@@frame[1],i[1][0]+@@frame[0],i[1][1]+@@frame[1]
			x2 += 1 if x2 == x1
			y2 += 1 if y1 == y2
			a1,b1,c1 = makeLineParams(x1,y1,x2,y2)
			xp, yp = crossDotByParams(a1,b1,c1,a2,b2,c2)
			next if xp.nan? || yp.nan?
			if ( ((xp >= x1 && xp <= x2) || (xp <= x1 && xp >= x2))&&
				 ((yp >= y1 && yp <= y2) || (yp <= y1 && yp >= y2))&&
				 ((xp >= x3 && xp <= x4) || (xp <= x3 && xp >= x4))&&
				 ((yp >= y3 && yp <= y4) || (yp <= y3 && yp >= y4))
			   )
				a << [ xp.round, yp.round]
			end
			break if a.size == 2
		end
		if ( a.size == 2 && lengthOfVector(x3-a[0][0],y3-a[0][1]) > lengthOfVector(x3-a[1][0],y3-a[1][1])  )
			a[1][0],a[0][0] = a[0][0],a[1][0]
			a[1][1],a[0][1] = a[0][1],a[1][1]
		end
		a.insert(0,[x3,y3])
		a << [x4,y4]
		label = true
		x4, y4 = x3+10000000, y3 + 2
		a2,b2,c2 = makeLineParams( x3,y3, x4, y4 )
		for i in @frame
			x1,y1,x2,y2 = i[0][0]+@@frame[0],i[0][1]+@@frame[1],i[1][0]+@@frame[0],i[1][1]+@@frame[1]
			x2 += 1 if x2 == x1
			y2 += 1 if y1 == y2
			a1,b1,c1 = makeLineParams(x1,y1,x2,y2)
			xp, yp = crossDotByParams(a1,b1,c1,a2,b2,c2)
			next if xp.nan? || yp.nan?
			if ( ((xp > x1 && xp < x2) || (xp < x1 && xp > x2))&&
				 ((yp > y1 && yp < y2) || (yp < y1 && yp > y2))&&
				 ((xp > x3 && xp < x4) || (xp < x3 && xp > x4))&&
				 ((yp > y3 && yp < y4) || (yp < y3 && yp > y4))
			   )
				label = !label
			end
		end
		return a,label
	end
	def DrawAlgorythm
		if @paint_mode != :Frame
			old2_DrawAlgorythm
		else
			@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0,255) )
			for i in @mouse_clicked_to
				justDrawDot(i[0],i[1]);
			end
			for i in @drawCommands
				self.send(i[0],i[1])
			end
			@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0,255) )
			@drawCommands.clear();
#			puts "    "+@drawLines.size.to_s
			for i in @drawLines
				if @frame
					d,st_color = findP( i[1] )
					color = Qt::Color.new(255,0,0,255)
					color = Qt::Color.new(0,0,0,255) if st_color
					@pa.brush = Qt::Brush.new( color )
					for u in (0..d.size-2)
						self.send(i[0],[d[u],d[u+1]])
						st_color = !st_color
						color = Qt::Color.new(255,0,0,255)
						color = Qt::Color.new(0,0,0,255) if st_color
						@pa.brush = Qt::Brush.new( color )
					end
#					puts 
				else
					self.send(i[0],i[1])
				end
			end
			@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,255,255) )
			FrameDrawAlgorythm() if @frame
			@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0,255) )
			@field.each { |x,y| justDrawDot(x[0],x[1]) }
		end
	end
	
=begin
	функция justDrawFrame генерирует изображение фрейма
		входные данные:
			массив точек задающих фрейм
=end
	def justDrawFrame(m)
		@frame = []
		mc = m.clone
		return nil if m.size == 0
		if m.size == 1
			@frame << [[m[0][0],m[0][1]],[m[0][0],m[0][1]]]
			return
		end
		dots = Array.new
		i = find_lowest( m )
		f = m[i].clone
		dots.push( [ m[i][0] , m[i][1] ] )
		i = find_next(m,i,dots,f)
		while ( m[i][0] != f[0] || m[i][1] != f[1] )
			dots.push( [ m[i][0] , m[i][1] ] )
			i = find_next(m,i,dots,f)
		end
		st = dots.size
		dots[st] = [dots[0][0],dots[0][1]]
		for i in 0..dots.size-2
			m = Array.new
			m[0] = [ dots[i][0]   , dots[i][1]   ]
			m[1] = [ dots[i+1][0] , dots[i+1][1] ]
			@frame << m
		end
	end
	def FrameMode()
		return if @paint_mode != :Paint
		@paint_mode = :Frame
		StartWorkAction :DrawFrame
		@@frame = [0,0]
		repaint
	end
	def NoFrameMode()
		return if @paint_mode != :Frame
		@paint_mode = :Paint
		@frame = nil
		@@frame = nil
		repaint
	end

	def connectActions()
		old6_connectActions
		@frame = nil
		@@frame = nil
		@commands[:DrawFrame] = 	[
			:saveWhileMouse,
			:justDrawFrame
									];
		
		connect( @f.actionFrameMode, SIGNAL('triggered()') , self , SLOT('FrameMode()') )
		connect( @f.actionNoFrameMode , SIGNAL('triggered()') , self , SLOT('NoFrameMode()') )
		
	end

end