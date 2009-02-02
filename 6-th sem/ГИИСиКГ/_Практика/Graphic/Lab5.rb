require 'Lab4'

class GraphWindow

	slots 'ProectionMode()', 'NoProectionMode()'

=begin
	функция CreateObjectCoordinates генерирует начальные значения куба
=end
	def CreateObjectCoordinates()
		@@o = []
		left_x =  -50
		right_x =  50
		left_y =  -50
		right_y =  50
		left_z =  250
		right_z = 350
		@@o.push [[ left_x , right_y  , left_z , 1 ] , [  right_x  ,  right_y , left_z , 1 ]]
		@@o.push [[  right_x  , right_y  , left_z , 1 ] , [  right_x  , left_y , left_z , 1 ]]
		@@o.push [[ left_x , left_y , left_z , 1 ] , [  right_x  , left_y , left_z , 1 ]]
		@@o.push [[ left_x , left_y , left_z , 1 ] , [ left_x ,  right_y , left_z , 1 ]]

		@@o.push [[ left_x ,  right_y , right_z , 1 ] , [  right_x  ,  right_y , right_z , 1 ]]
		@@o.push [[  right_x  ,  right_y , right_z , 1 ] , [  right_x  , left_y , right_z , 1 ]]
		@@o.push [[ left_x , left_y , right_z , 1 ] , [  right_x  , left_y , right_z , 1 ]]
		@@o.push [[ left_x , left_y , right_z , 1 ] , [ left_x ,  right_y , right_z , 1 ]]

		@@o.push [[ left_x ,  right_y , left_z , 1 ] , [ left_x ,  right_y , right_z , 1 ]]
		@@o.push [[  right_x  ,  right_y , left_z , 1 ] , [ right_x  ,  right_y , right_z , 1 ]]
		@@o.push [[ left_x , left_y , left_z , 1 ] , [ left_x , left_y , right_z , 1 ]]
		@@o.push [[  right_x  , left_y , left_z , 1 ] , [ right_x  , left_y , right_z , 1 ]]

		@@o_g = []
		@@o_g.push []
		@@o_g.last << 3 << 8 << 7 << 10
		@@o_g.push []
		@@o_g.last << 11 << 1 << 9 << 5
		@@o_g.push []
		@@o_g.last << 0 << 8 << 4 << 9
		@@o_g.push []
		@@o_g.last << 2 << 11 << 10 << 6
		@@o_g.push []
		@@o_g.last << 0 << 1 << 2 << 3
		@@o_g.push []
		@@o_g.last << 4 << 5 << 6 << 7

		@@o_d = []
		@@o_d << @@o[0][0] << @@o[0][1] << @@o[1][1] << @@o[2][0]
		@@o_d << @@o[4][0] << @@o[4][1] << @@o[5][1] << @@o[6][0]

		@@e = e_make()
		@@t = e_make()
		@@t[4,4] = 0.0
		@@t[3,4] = -0.002
#		@@t[4,3] = -50
	end

	alias :old5_connectActions :connectActions
	alias :old_addedKeyReleaseEvent :addedKeyReleaseEvent
	alias :old_DrawAlgorythm :DrawAlgorythm
	alias :old_DrawDot :DrawDot
	
=begin
	функция ObjectDrawAlgorythm отрисовывает куб
=end
	def ObjectDrawAlgorythm
#		@@e.each { |i| i = (1.0*((i*10000).round))/10000 }
		oo = delete_unvisible(@@o) if @deleting_mode
		oo = @@o unless @deleting_mode
		for i in oo
			m = make2d_dot_array( i[0] , i[1] )
			justDrawADCLine( m )
		end
	end
	
=begin
	функция make2d_dot_array применяет эффекты и проецирует куб на плоскость, по двум точкам заданным x, y
	входные параметры 
				точки куба x, y задающие одну из граней куба
	выходные параметры 
				массив точек подготовленных для функции генерации отрезков
=end	
def make2d_dot_array(x,y)
		p1 = Array2.new
		p1[1,1],p1[1,2],p1[1,3],p1[1,4] = 1.0*x[0], 1.0*x[1], 1.0*x[2], 1.0*x[3]
		p12 = p1*@@e*@@t
		dz =  p12[1,4]
		(1..4).each { |i| p12[1,i] = p12[1,i] / dz } if dz != 0

		p2 = Array2.new
		p2[1,1],p2[1,2],p2[1,3],p2[1,4] = 1.0*y[0], 1.0*y[1], 1.0*y[2], 1.0*y[3]
		p22 = p2*@@e*@@t
		dz = p22[1,4]
		(1..4).each { |i| p22[1,i] = p22[1,i] / dz } if dz != 0
		m = []
		m[0] = [ p12[1,1].round , p12[1,2].round ]
		m[1] = [ p22[1,1].round , p22[1,2].round ]
		m
	end


	def DrawAlgorythm
		if @paint_mode != :Proection
			old_DrawAlgorythm
		else
			@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0,255) )
			ObjectDrawAlgorythm()
			@drawCommands.clear();
			for i in @drawLines
				self.send(i[0],i[1])
			end
			@field.each { |x,y| justDrawDot(x[0],x[1]) }
		end
	end
	def DrawDot(x,y,z = 0)
		unless @paint_mode == :Proection
			old_DrawDot(x,y)
		else
			justDrawDot(x,y)
		end
	end	

=begin
	функция e_make создаёт единичную матрицу
	выходные параметры 
		единичная матрица 4х4
=end
	def e_make()
		e = Array2.new
		e[1,1],e[1,2],e[1,3],e[1,4]=  1.0 ,  0.0 ,  0.0 ,  0.0
		e[2,1],e[2,2],e[2,3],e[2,4]=  0.0 ,  1.0 ,  0.0 ,  0.0
		e[3,1],e[3,2],e[3,3],e[3,4]=  0.0 ,  0.0 ,  1.0 ,  0.0
		e[4,1],e[4,2],e[4,3],e[4,4]=  0.0 ,  0.0 ,  0.0 ,  1.0
		e
	end
=begin
	функция moveRight применяет эффект движения объекта вправо
=end
	def moveRight()
		e = e_make()
		e[4,1] = @@delta
		@@e = @@e*e
		repaint
	end
=begin
	функция moveLeft применяет эффект движения объекта влево
=end
	def moveLeft()
		e = e_make()
		e[4,1] = -@@delta
		@@e = @@e*e
		repaint
	end
=begin
	функция moveUp применяет эффект движения объекта вверх
=end
	def moveUp()
		e = e_make()
		e[4,2] = @@delta
		@@e = @@e*e
		repaint
	end	
=begin
	функция moveDown применяет эффект движения объекта вниз
=end
	def moveDown()
		e = e_make()
		e[4,2] = -@@delta
		@@e = @@e*e
		repaint
	end	
=begin
	функция moveToUs применяет эффект движения объекта на нас
=end
	def moveToUs()
		e = e_make()
		e[4,3] = @@delta
		@@e = @@e*e
		repaint
	end	
=begin
	функция moveFromUs применяет эффект движения объекта от нас
=end
	def moveFromUs()
		e = e_make()
		e[4,3] = -@@delta
		@@e = @@e*e
		repaint
	end	
=begin
	функция makeYBigger применяет эффект положительного масштабирования объекта по оси У
=end
	def makeYBigger()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[2,2] = @@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция makeYSmaller применяет эффект отрицательного масштабирования объекта по оси У
=end
	def makeYSmaller()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[2,2] = 1.0/@@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция makeXBigger применяет эффект положительного масштабирования объекта по оси Х
=end
	def makeXBigger()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1] = @@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция makeXSmaller применяет эффект отрицательного масштабирования объекта по оси Х
=end
	def makeXSmaller()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1] = 1.0/@@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция makeZSmaller применяет эффект положительного масштабирования объекта по оси Z
=end
	def makeZBigger()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[3,3] = @@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция makeZSmaller применяет эффект отрицательного масштабирования объекта по оси Z
=end
	def makeZSmaller()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[3,3] = 1.0/@@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция replace2 применяет эффект переноса на вектор dx, dy, dz
		входные параметры:
			dx, dy, dz - параметры вектора переноса
=end
	def replace2(dx,dy,dz)
		e = e_make()
		e[4,1],e[4,2],e[4,3] = dx, dy, dz
		@@e = @@e*e
	end
	def turnGeneralStart()
#puts @@e
#puts
		p1,p2 = Array2.new, Array2.new
		p1[1,1],p1[1,2],p1[1,3],p1[1,4] = 1.0*@@o[2][0][0], 1.0*@@o[2][0][1], 1.0*@@o[2][0][2], 1.0*@@o[2][0][3]
		p2[1,1],p2[1,2],p2[1,3],p2[1,4] = 1.0*@@o[4][1][0], 1.0*@@o[4][1][1], 1.0*@@o[4][1][2], 1.0*@@o[4][1][3]
		p1 = p1 * @@e
		p2 = p2 * @@e
#puts p1,p2
		x1,y1,z1 = p1[1,1],p1[1,2],p1[1,3]
		x2,y2,z2 = p2[1,1],p2[1,2],p2[1,3]
#puts x1,y1,z1,"",x2,y2,z2," ",""
		dx, dy, dz = ((1.0*x2-x1) / 2)+x1, ((1.0*y2-y1)/2)+y1, ((1.0*z2-z1) / 2) +z1
#puts dx,dy,dz
#puts "....."
		return dx,dy,dz
	end
=begin
	функция turnXLeft применяет эффект поворота объекта по оси Z
=end
	def turnXLeft()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1], e[1,2] =  Math::cos( @@angle ) ,  Math::sin( @@angle )
		e[2,1], e[2,2] = -Math::sin( @@angle ) ,  Math::cos( @@angle )
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция turnXRight применяет эффект поворота объекта по оси Z
=end
	def turnXRight()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1], e[1,2] =  Math::cos( -@@angle ) ,  Math::sin( -@@angle )
		e[2,1], e[2,2] = -Math::sin( -@@angle ) ,  Math::cos( -@@angle )
		@@e = @@e*e

		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция turnYLeft применяет эффект поворота объекта по оси X
=end
	def turnYLeft()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[2,2], e[2,3] =  Math::cos( @@angle ) ,  Math::sin( @@angle )
		e[3,2], e[3,3] = -Math::sin( @@angle ) ,  Math::cos( @@angle )
		@@e = @@e*e

		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция turnYRight применяет эффект поворота объекта по оси X
=end
	def turnYRight()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[2,2], e[2,3] =  Math::cos( -@@angle ) ,  Math::sin( -@@angle )
		e[3,2], e[3,3] = -Math::sin( -@@angle ) ,  Math::cos( -@@angle )
		@@e = @@e*e

		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция turnZLeft применяет эффект поворота объекта по оси Y
=end
	def turnZLeft()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1], e[1,3] =  Math::cos( @@angle ) ,  Math::sin( @@angle )
		e[3,1], e[3,3] = -Math::sin( @@angle ) ,  Math::cos( @@angle )
		@@e = @@e*e

		replace2(dx,dy,dz)
		repaint
	end
=begin
	функция turnZRight применяет эффект поворота объекта по оси Y
=end
	def turnZRight()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1], e[1,3] =  Math::cos( -@@angle ) ,  Math::sin( -@@angle )
		e[3,1], e[3,3] = -Math::sin( -@@angle ) ,  Math::cos( -@@angle )
		@@e = @@e*e

		replace2(dx,dy,dz)
		repaint
	end
	def addedKeyReleaseEvent(e)
		old_addedKeyReleaseEvent(e)
		moveLeft() if (e.key == 65)				# a
		moveRight() if (e.key == 68)			# d
		moveUp() if (e.key == 87)				# w
		moveDown() if (e.key == 83)        		# s
		moveToUs() if (e.key == 43)        	 	# -
		moveFromUs() if (e.key == 45)       	# +
		
		makeXBigger() if (e.key == 16777222)	# insert
		makeXSmaller() if (e.key == 16777223)	# delete
		makeYBigger() if (e.key == 16777232)	# home
		makeYSmaller() if (e.key == 16777233)	# end
		makeZBigger() if (e.key == 16777238)	# pageup
		makeZSmaller() if (e.key == 16777239)	# pagedown
	
		turnXLeft() if (e.key == 55)			# 7
		turnXRight() if (e.key == 56)     		# 8
		turnYLeft() if (e.key == 52)			# 4
		turnYRight() if (e.key == 53)     		# 5
		turnZLeft() if (e.key == 49)			# 1
		turnZRight() if (e.key == 50)     		# 2
	end
	def ProectionMode()
		return if @paint_mode != :Paint
		@paint_mode = :Proection
		repaint
	end
	def NoProectionMode()
		return unless @paint_mode == :Proection
		@paint_mode = :Paint
		repaint
	end

	def connectActions
		@@angle = Math::PI/20;
		@@delta = 3
		@@k = 1.5
		CreateObjectCoordinates()
		old5_connectActions
		connect( @f.actionProecirovanie_mode, SIGNAL('triggered()') , self , SLOT('ProectionMode()') )
		connect( @f.actionNormal_mode , SIGNAL('triggered()') , self , SLOT('NoProectionMode()') )

	end

end