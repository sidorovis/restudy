require 'Lab4'

class GraphWindow

	slots 'ProectionMode()', 'NoProectionMode()'

	def CreateObjectCoordinates()
		@@o = []
		left_x = -5
		right_x = 5
		left_y = -5
		right_y = 5
		left_z = 5
		right_z = 15
		@@o[0] = [[ left_x , right_y  , left_z , 1 ] , [  right_x  ,  right_y , left_z , 1 ]]
		@@o[1] = [[  right_x  , right_y  , left_z , 1 ] , [  right_x  , left_y , left_z , 1 ]]
		@@o[2] = [[ left_x , left_y , left_z , 1 ] , [  right_x  , left_y , left_z , 1 ]]
		@@o[3] = [[ left_x , left_y , left_z , 1 ] , [ left_x ,  right_y , left_z , 1 ]]

		@@o[4] = [[ left_x ,  right_y , right_z , 1 ] , [  right_x  ,  right_y , right_z , 1 ]]
		@@o[5] = [[  right_x  ,  right_y , right_z , 1 ] , [  right_x  , left_y , right_z , 1 ]]
		@@o[6] = [[ left_x , left_y , right_z , 1 ] , [  right_x  , left_y , right_z , 1 ]]
		@@o[7] = [[ left_x , left_y , right_z , 1 ] , [ left_x ,  right_y , right_z , 1 ]]

		@@o[8 ] = [[ left_x ,  right_y , left_z , 1 ] , [ left_x ,  right_y , right_z , 1 ]]
		@@o[9 ] = [[  right_x  ,  right_y , left_z , 1 ] , [ right_x  ,  right_y , right_z , 1 ]]
		@@o[10] = [[ left_x , left_y , left_z , 1 ] , [ left_x , left_y , right_z , 1 ]]
		@@o[11] = [[  right_x  , left_y , left_z , 1 ] , [ right_x  , left_y , right_z , 1 ]]

		@@e = e_make()
		@@t = e_make()
		@@t[4,4] = 0.0
		@@t[3,4] = 0.02
#		@@t[4,3] = -10
	end

	alias :old5_connectActions :connectActions
	alias :old_addedKeyReleaseEvent :addedKeyReleaseEvent
	alias :old_DrawAlgorythm :DrawAlgorythm
	alias :old_DrawDot :DrawDot
	
	def ObjectDrawAlgorythm
		for i in @@o
			m = make2d_dot_array( i[0] , i[1] )
			justDrawADCLine( m )
		end
	end
	def make2d_dot_array(x,y)
		p1 = Array2.new
		p1[1,1],p1[1,2],p1[1,3],p1[1,4] = 1.0*x[0], 1.0*x[1], 1.0*x[2], 1.0*x[3]
		p1 = p1*@@e
#		(1..4).each { |i| p1[1,i] = (p1[1,i]*100).round*1.0/100 }
#puts p1
#puts
		p12 = p1*@@t
		dz =  p12[1,4]
		(1..4).each { |i| p12[1,i] = p12[1,i] / dz } if dz != 0
		p2 = Array2.new
		p2[1,1],p2[1,2],p2[1,3],p2[1,4] = 1.0*y[0], 1.0*y[1], 1.0*y[2], 1.0*y[3]
		p2 = p2*@@e
#puts p2
#puts "==========================================================="
		p22 = p2*@@t
	dz = p22[1,4]
		(1..4).each { |i| p22[1,i] = p22[1,i] / dz } if dz != 0
		m = []
		m[0] = [ p12[1,1].round , p12[1,2].round ]
		m[1] = [ p22[1,1].round , p22[1,2].round ]
		m
	end

	def DrawAlgorythm
#		puts @pn_mode
		if @pn_mode == :Normal
			old_DrawAlgorythm
		else
			@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0,255) )
			ObjectDrawAlgorythm()
			@drawCommands.clear();
			@field.each { |x,y| justDrawDot(x[0],x[1]) }
		end
	end
	def DrawDot(x,y,z = 0)
		if @pn_mode == :Normal
			old_DrawDot(x,y)
		else
			justDrawDot(x,y)
		end
	end	
	def ProectionMode()
		@pn_mode = :Proection
		repaint
	end
	def NoProectionMode()
		@pn_mode = :Normal
		repaint
	end
	
	def e_make()
		e = Array2.new
		e[1,1],e[1,2],e[1,3],e[1,4]=  1.0 ,  0.0 ,  0.0 ,  0.0
		e[2,1],e[2,2],e[2,3],e[2,4]=  0.0 ,  1.0 ,  0.0 ,  0.0
		e[3,1],e[3,2],e[3,3],e[3,4]=  0.0 ,  0.0 ,  1.0 ,  0.0
		e[4,1],e[4,2],e[4,3],e[4,4]=  0.0 ,  0.0 ,  0.0 ,  1.0
		e
	end
	def moveRight()
		e = e_make()
		e[4,1] = @@delta
		@@e = @@e*e
		repaint
	end
	def moveLeft()
		e = e_make()
		e[4,1] = -@@delta
		@@e = @@e*e
		repaint
	end
	def moveUp()
		e = e_make()
		e[4,2] = @@delta
		@@e = @@e*e
		repaint
	end	
	def moveDown()
		e = e_make()
		e[4,2] = -@@delta
		@@e = @@e*e
		repaint
	end	
	def moveToUs()
		e = e_make()
		e[4,3] = @@delta
		@@e = @@e*e
		repaint
	end	
	def moveFromUs()
		e = e_make()
		e[4,3] = -@@delta
		@@e = @@e*e
		repaint
	end	
	def makeYBigger()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[2,2] = @@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
	def makeYSmaller()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[2,2] = 1.0/@@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
	def makeXBigger()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1] = @@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
	def makeXSmaller()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[1,1] = 1.0/@@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
	def makeZBigger()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[3,3] = @@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
	def makeZSmaller()
	    dx,dy,dz = turnGeneralStart()
		replace2(-dx,-dy,-dz)
		e = e_make()
		e[3,3] = 1.0/@@k
		@@e = @@e*e
		replace2(dx,dy,dz)
		repaint
	end
	
	
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

	def connectActions
		@@angle = Math::PI/20;
		@@delta = 3
		@@k = 1.5
		CreateObjectCoordinates()
		@pn_mode = :Normal
		old5_connectActions
		connect( @f.actionProecirovanie_mode, SIGNAL('triggered()') , self , SLOT('ProectionMode()') )
		connect( @f.actionNormal_mode , SIGNAL('triggered()') , self , SLOT('NoProectionMode()') )

	end

end