require 'Lab1'

class GraphWindow

	slots 'DrawEllipse()','Draw2Pow()', 'justDrawEllipse()', 'justDraw2DimLine()'
	
  private
=begin
	функция len возвращает длинну отрезка
	входные параметры координаты начала x1, y1 и координаты конца отрезка x2, y2
	выходные параметры длинна отрезка 
=end
	def len(x0,y0,x1,y1)
		(((y0 - y1)**2 + (x0 - x1)**2)*1.0)**(1.0/2)
	end
=begin
	функция f_ellipse возвращает расстояние от заданной точки, до графика эллипса с заданными параметрами
	входные параметры:
		tx, ty : координаты точки от которой мы ищем расстояние до эллипса
		x0, y0 : координаты центра эллипса
		r1, r2 : радиусы эллипса
	выходные параметры длинна растояния между точкой и эллипсом
=end
	def f_ellipse(tx,x0,ty,y0,r1,r2)
		(( (((tx-x0)*1.0) **2)/(r1**2)+(((ty-y0)*1.0)**2)/(r2**2) ) - 1).abs
	end
=begin
	функция DrawMirroredDot отрисовывает отражённую точку относительно координат
	входные параметры :
		координаты отражаемой точки x, y 
		координаты точки от которой идёт отражение x2, y2
	выходные параметры отсутствуют
=end
	def DrawMirroredDot(x,y,x0,y0)
		print " x= #{x}     y= #{y}  \n" if $log
		DrawDot(x,y)
		DrawDot(x  ,y0 - ( y - y0))
		DrawDot(x0 - (x - x0) ,y )
		DrawDot(x0 - (x - x0) ,y0 - ( y - y0))
	end
  public
=begin
	функция justDrawEllipse отрисовывает эллипс по входным параметрам
	входные параметры :
		массив точек задающих центр эллипса, и два его радиуса
	выходные параметры отсутствуют
=end
	def justDrawEllipse(m)
		puts "--------------------------------------"	if $log
		x0, y0, x1, y1, x2, y2 = m[0][0], m[0][1], m[1][0], m[1][1], m[2][0], m[2][1]
		m1,m2,m3 = Array.new, Array.new, Array.new
		r1 = len(x0,y0,x1,y1)	# получение первого радиуса эллипса (расстояние между первой и второй входными точками)
		r2 = len(x0,y0,x2,y2)	# получение второго радиуса эллипса (расстояние между первой и третьей входными точками)
		print " a = ",r1,"   b = ",r2,"\n" if $log
		x = x0
		y = (y0 + r2).to_i		# установка начальных координат отрисовки (поднятие y над центром на расстояние второго радиуса)
		DrawMirroredDot(x,y,x0,y0)		# отрисовка четырёх отражённых точек
		while (y > y0)		# пока не отрисовали четверть эллипса
			d1 = f_ellipse(x+1, x0, y, y0, r1, r2)	# считаем расстояние сдвига по иксу вправо
			d2 = f_ellipse(x+1, x0, y-1, y0, r1, r2)	# считаем расстояние сдвига по иксу вправо и по игреку вниз
			d3 = f_ellipse(x, x0, y-1, y0, r1, r2)	# считаем расстояние сдвига по игреку вниз
			print d1," ",d2," ",d3,"\n"		if $log
			if ( d1 < d2 && d1 < d3)	# определяем какую точку намрисовать в зависимости от того какая ближе к функции эллипса
				x = x + 1 
			else
				if ( d2 < d1 && d2 < d3)
					x, y = x+1, y-1
				else
					y = y - 1
				end
			end
			DrawMirroredDot(x,y,x0,y0)	# отрисовка четырёх отражённых точек
		end
		puts "--------------------------------------"	if $log
	end
=begin
	функция justDraw2DimLine отрисовывает линию второго порядка по входным параметрам
	входные параметры :
		массив точек задающих центр линии второго порядка, и два его радиуса
	выходные параметры отсутствуют
=end
	def justDraw2DimLine(m)
		puts "--------------------------------------"	if $log
		x0, y0, x1, y1, x2, y2 = m[0][0], m[0][1], m[1][0], m[1][1], m[2][0], m[2][1]
		m1,m2,m3 = Array.new, Array.new, Array.new
		r1 = len(x0,y0,x1,y1)
		r2 = len(x0,y0,x2,y2)
		print " a = ",r1,"   b = ",r2,"\n" if $log
		x = x0
		y = (y0 + r2).to_i	# установка начальных координат отрисовки (поднятие y над центром на расстояние второго радиуса)
		DrawMirroredDot(x,y,x0,y0)	# отрисовка четырёх отражённых точек
		while (y < 1000)		# пока не отрисовали 1000 точек
			d1 = f_draw2pow(x+1, x0, y, y0, r1, r2)	# считаем расстояние сдвига по иксу вправо
			d2 = f_draw2pow(x+1, x0, y+1, y0, r1, r2)	# считаем расстояние сдвига по иксу вправо и по игреку вверх
			d3 = f_draw2pow(x, x0, y+1, y0, r1, r2)	# считаем расстояние сдвига по игреку вверх
			print d1," ",d2," ",d3,"\n"		if $log
			if ( d1 < d2 && d1 < d3)	# определяем какую точку намрисовать в зависимости от того какая ближе к функции эллипса
				x = x + 1 
			else
				if ( d2 < d1 && d2 < d3)
					x, y = x+1, y+1
				else
					y = y + 1
				end
			end
			DrawMirroredDot(x,y,x0,y0)	# отрисовка четырёх отражённых точек
		end
		puts "--------------------------------------"	if $log
	end

	def DrawEllipse()
		StartWorkAction :DrawEllipse
	end

	def Draw2Pow()
=begin
	функция f_ellipse возвращает расстояние от заданной точки, до графика заданной линии второго порядка
	входные параметры:
		tx, ty : координаты точки от которой мы ищем расстояние до линии
		x0, y0 : координаты центра линии
		r1, r2 : радиусы линии
	выходные параметры длинна растояния между точкой и эллипсом
=end	
		def self.f_draw2pow(tx,x0,ty,y0,r1,r2)
			(( -(((tx-x0)*1.0) **2)/(r1**2)+(((ty-y0)*1.0)**2)/(r2**2) ) - 1).abs
		end
		StartWorkAction :Draw2Pow
	end

	alias :old2_connectActions :connectActions
	def connectActions
		old2_connectActions
		
			@commands[:DrawEllipse] = 	[
					:saveMouse,
					:saveMouse,
					:saveMouse,
					:justDrawEllipse
										];
			@commands[:Draw2Pow] = 	[
					:saveMouse,
					:saveMouse,
					:saveMouse,
					:justDraw2DimLine
										];
		connect( @f.actionEllipse, SIGNAL('triggered()') , self , SLOT('DrawEllipse()') )
		connect( @f.actionDraw2Pow, SIGNAL('triggered()') , self , SLOT('Draw2Pow()') )
		
	end
end