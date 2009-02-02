require 'Lab6'

class GraphWindow

	slots 'Deleting()', 'NotDeleting()'

	alias :old7_connectActions :connectActions

=begin
	функция create2d_arr подготавливает матрицу точки, с использованными эффектами
		входные параметры:
			а - массив задающий точку
		выходные паарметры:
			матрица точки с применёнными эффектами
=end
	def create2d_arr( a )
		p1 = Array2.new
		p1[1,1],p1[1,2],p1[1,3],p1[1,4] = 1.0*a[0], 1.0*a[1], 1.0*a[2], 1.0*a[3]
		p11 = p1*@@e
		return p11
	end
=begin
	функция makeABCDv создаёт параметры вектора
		входные параметры:
			r - массив задающий вектор в пространстве
		выходные параметры:
			параметры a, b, c задающие вектор в пространстве
=end
	def makeABCDv( r )
		p11 = create2d_arr( r[0] )
		p22 = create2d_arr( r[1] )
		a = p22[1,1] - p11[1,1]
		b = p22[1,2] - p11[1,2]
		c = p22[1,3] - p11[1,3]
#puts " #{a} #{b} #{c} " 
		return a,b,c
	end
=begin
	функция makeABCD умножает векторы в пространстве
		входные параметры:
			r - массив задающий два вектора в пространстве
		выходные паарметры:
			параметры a, b, c задающие результат векторного умножения двух векторов
=end
	def makeABCD( r )
		a1,b1,c1 = makeABCDv( @@o[ r[ 0 ] ] )
		a2,b2,c2 = makeABCDv( @@o[ r[ 1 ] ] )
		a , b , c = b1*c2-c1*b2 , c1*a2-a1*c2 , a1*b2-b1*a2
		d = makeD( r,a,b,c )
#puts "     -> #{a} #{b} #{c} #{d}" 
		return [a,b,c,d]
	end
=begin
	функция makeD создаёт параметр D плоскости по точки принадлежазей плоскости и остальным коэфициентам плоскости
		входные параметры:
			r - точка принадлежащая плоскости
			a, b, c паарметры плоскости
		выходные паарметры:
			параметр d задающий плоскость
=end
	def makeD( r, a,b,c)
		p1 = Array2.new
		p1[1,1],p1[1,2],p1[1,3],p1[1,4] = 1.0*@@o[ r[ 0 ] ][0][0], 1.0*@@o[ r[ 0 ] ][0][1], 1.0*@@o[ r[ 0 ] ][0][2], 1.0*@@o[ r[ 0 ] ][0][3]
		p1 = p1*@@e
		d = -a*p1[1,1]-b*p1[1,2]-c*p1[1,3]
	end

=begin
	функция getCenter вычисляет центр фигуры по её точкам
		выходные паарметры:
			координаты x, y, z - координаты центра фигуры
=end
	def getCenter()
		x = y = z = 0.0
		@@o_d.each { |dot| p1 = create2d_arr( dot ); x+=p1[1,1];y+=p1[1,2];z+=p1[1,3]; }
		x /= @@o_d.size
		y /= @@o_d.size
		z /= @@o_d.size
		x = (1.0*((x*1_000_000_000).round))/1_000_000_000
		y = (1.0*((y*1_000_000_000).round))/1_000_000_000
		z = (1.0*((z*1_000_000_000).round))/1_000_000_000
		return x,y,z
	end
	
=begin
	функция delete_unvisible удаляет невидимые линии из фигуры
		входные параметры: массив отрезков задающих фигуру
		выходные параметры:
			массив видимых отрезков задающих фигуру
=end
	def delete_unvisible( m )
#		puts "\n\n\n\n\n"
		o1 = []
		xc,yc,zc = getCenter()
		for gran in @@o_g
#		puts "------------------------------ #{xc} , #{yc} , #{zc} "
			abcdv = makeABCD( gran )
#			puts abcdv.join( "\t ")
			if ( abcdv[0] * xc+abcdv[1] * yc+abcdv[2] * zc + abcdv[3] < 0 )
				abcdv[0] *= -1.0
				abcdv[1] *= -1.0
				abcdv[2] *= -1.0
				abcdv[3] = makeD( gran, abcdv[0], abcdv[1], abcdv[2] )
			end
			
			v = [0.0,0.0,0.0,1]
			for rebro_index in gran
				for dot in @@o[ rebro_index ]
					p1 = Array2.new
					p1[1,1],p1[1,2],p1[1,3],p1[1,4] = 1.0*dot[0], 1.0*dot[1], 1.0*dot[2], 1.0*dot[3]
					p1 = p1*@@e
					v[0] += p1[1,1]
					v[1] += p1[1,2]
					v[2] += p1[1,3]
				end
			end
			v[0] /= 2
			v[1] /= 2
			v[2] /= 2
			if ( abcdv[0] * v[0] + abcdv[1] * v[1] + abcdv[2] * v[2] + abcdv[3] * v[3] > 0 )
#			if  @@o_g.index( gran ) > 3
				for rebro_index in gran
						o1 << @@o[ rebro_index ]
				end
=begin
			pp = Array2.new
			pp[1,1] , pp[1,2] , pp[1,3] , pp[1,4] = @@o[ gran[0] ][0][0] , @@o[ gran[0] ][0][1] , @@o[ gran[0] ][0][2] , @@o[ gran[0] ][0][3]
			p1 = Array2.new
			p1[1,1] , p1[1,2] , p1[1,3] ,p1[1,4] = @@o[ gran[0] ][0][0]+abcdv[0]*0.1  , @@o[ gran[0] ][0][1]+abcdv[1]*0.1 , @@o[ gran[0] ][0][2]+abcdv[2]*0.1 , @@o[ gran[0] ][0][3]
			pp = pp*@@e*@@t
			dz =  pp[1,4]
			(1..4).each { |i| pp[1,i] = pp[1,i] / dz } if dz != 0
			p1 = p1*@@e*@@t
			dz =  p1[1,4]
			(1..4).each { |i| p1[1,i] = p1[1,i] / dz } if dz != 0
			justDrawADCLine( [ [ pp[1,1].round , pp[1,2].round] , [p1[1,1].round , p1[1,2].round]] )
=end
			end

#			end
		end
		o1
	end	       

	def Deleting
		return if @paint_mode != :Proection
		@deleting_mode = true
		repaint
	end
	def NotDeleting
		return unless @paint_mode == :Proection
		@deleting_mode = false
		repaint
		end

	def connectActions()
		old7_connectActions
		@deleting_mode = false
		
		connect( @f.actionDeleting, SIGNAL('triggered()') , self , SLOT('Deleting()') )
		connect( @f.actionNotDeleting , SIGNAL('triggered()') , self , SLOT('NotDeleting()') )
				
	end

end