require 'GraphWindow'

class GraphWindow
	slots 'DrawADCLine()', 'justDrawADCLine()', 'DrawBrezenhemLine()', 'justDrawBrezenhemLine()'
=begin
	функция DrawLineGeneral реализует алгоритм генерации отразка в особых случаях (вертикальный, горизонтальный, под углом 45%)
	входные параметры координаты начала x1, y1 и координаты конца отрезка x2, y2
	выходные параметры логическая переменная: истинна - линия является особым случаем 
=end
	def DrawLineGeneral(x1,y1,x2,y2)
		dx, dy, dop = x2 - x1, y2 - y1, 1
		if dx == 0							# случай отрисовки горизонтальной линии
			x1, y1, x2, y2 = x2, y2, x1, y1 if y1 > y2		
			(y1..y2).each { |i| justDrawDot(x1,i) }
			return true
		end
		if dy == 0							# случай отрисовки вертикальной линии
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2		
			(x1..x2).each { |i| justDrawDot(i,y1) }
			return true
		end
		if dx.abs == dy.abs					# случай отрисовки линии под углом 45%
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2		# поворот координат для прохода от меньшего к большему
			dop = -1 if ( y1 > y2 )
			(x1..x2).each { |i| justDrawDot(i, y1 + (i - x1)*dop ) }
			return true
		end
		false
	end
=begin
	функция justDrawADCLine реализует алгоритм генерации отрезка алгоритмом ЦДА
	входные параметры массив точек содержащих начало и конец отрезка
	выходные параметры: нет
=end
	def justDrawADCLine(m)
		x1, y1, x2, y2 = m[0][0], m[0][1], m[1][0], m[1][1]
		puts "\t\t\tdrawADCLine  (#{x1}, #{y1})->(#{x2}, #{y2})" if $log
		puts "----------------------------------------" if $log
		return if DrawLineGeneral(x1,y1,x2,y2)			# проверка является ли линия особым случаем
		dx, dy = x2 - x1, y2 - y1
		if dx.abs > dy.abs						# случай когда шаг идёт по оси X
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2		# поворот координат для прохода от меньшего к большему
			dx, dy = x2 - x1, y2 - y1
			dy /= dx.to_f
			for i in ((x1..x2))
				if y1 + dy*(i-x1) >= 0			# для точек с координатами y большими нуля
					justDrawDot( i , (y1 + dy*(i-x1) + 0.5 ).to_i )
					puts " i = #{i}    x= #{i}     y= #{(y1 + dy*(i-x1))}   (x= #{i},     y= #{(y1 + dy*(i-x1) + 0.5 ).to_i})" if $log
				else							# иначе
					justDrawDot( i , (y1 + dy*(i-x1) - 0.5 ).to_i )
					puts " i = #{i}    x= #{i}     y= #{(y1 + dy*(i-x1))}   (x= #{i},     y= #{(y1 + dy*(i-x1) - 0.5 ).to_i})" if $log
				end
			end
		else									# случай когда шаг идёт по оси Y
			x1, y1, x2, y2 = x2, y2, x1, y1 if y1 > y2		# поворот координат для прохода от меньшего к большему
			dx, dy = x2 - x1, y2 - y1
			dx /= dy.to_f
			for i in (y1..y2)
				if x1 + dx*(i-y1) >=0			# для точек с координатами x большими нуля
					justDrawDot((x1 + dx*(i-y1) + 0.5 ).to_i , i )
					puts " i = #{i}    x= #{(x1 + dx*(i-y1))}     y= #{i}   (x= #{(x1 + dx*(i-y1) + 0.5 ).to_i}     y= #{i}) " if $log
				else							# иначе
					justDrawDot((x1 + dx*(i-y1) - 0.5 ).to_i , i )
					puts " i = #{i}    x= #{(x1 + dx*(i-y1))}     y= #{i}   (x= #{(x1 + dx*(i-y1) - 0.5 ).to_i}     y= #{i}) " if $log
				end
			end
		end
		puts "----------------------------------------" if $log
	end
=begin
	функция justDrawBrezenhemLine реализует алгоритм генерации отрезка алгоритмом Брезенхема
	входные параметры массив точек содержащих начало и конец отрезка
	выходные параметры: нет
=end
	def justDrawBrezenhemLine(m)
		x1, y1, x2, y2 = m[0][0], m[0][1], m[1][0], m[1][1]
		puts "\t\t\tdrawBrezenhemLine  (#{x1}, #{y1})->(#{x2}, #{y2})" if $log
		puts "----------------------------------------" if $log
		return if DrawLineGeneral(x1,y1,x2,y2)			# проверка является ли линия особым случаем
		dop, dx, dy = 1, x2 - x1, y2 - y1
		if dx.abs > dy.abs						# случай когда шаг идёт по оси X
			x1, y1, x2, y2 = x2, y2, x1, y1 if x1 > x2		# поворот координат для прохода от меньшего к большему
			dop *= -1 if y2 - y1 < 0			# вычисление суммируемого компонента для Y
			e, de, y = 0, dy.abs, y1
			for x in (x1..x2)
				justDrawDot(x,y)
				puts " x= #{x}    y= #{y}       e= #{e}" if $log
				e += de
				y, e = y + dop, e - dx.abs if 2 * e > dx.abs
			end
		else									# случай когда шаг идёт по оси Y
			x1, y1, x2, y2 = x2, y2, x1, y1 if y1 > y2		# поворот координат для прохода от меньшего к большему
			dop *= -1 if x2 - x1 < 0			# вычисление суммируемого компонента для X
			e, de, x = 0, dx.abs, x1
			for y in (y1..y2)
				justDrawDot(x,y)
				puts " x= #{x}    y= #{y}       e= #{e}" if $log
				e += de
				x, e = x + dop, e - dy.abs if 2 * e > dy.abs
			end
		end
		puts "----------------------------------------" if $log
	end
	def DrawADCLine()
		return unless @paint_mode == :Paint
		StartWorkAction :DrawADCLine
	end
# функция обрабатывающая нажатие кнопки в меню
	def DrawBrezenhemLine()
		return unless @paint_mode == :Paint
		StartWorkAction :DrawBrezenhemLine
	end
# функция подключения отрисовки алгоритмов
	alias :old_connectActions :connectActions
	def connectActions
		old_connectActions
											# алгоритм действий пользователя\пк для отрисовки линии алгоритмом ЦДА
		@commands[:DrawADCLine] = [
			:saveMouse,
			:saveMouse,
			:justDrawADCLine
									];

											# алгоритм действий пользователя\пк для отрисовки линии алгоритмом Брезенхема
		@commands[:DrawBrezenhemLine] = [
			:saveMouse,
			:saveMouse,
			:justDrawBrezenhemLine
									];

		connect( @f.actionADC , SIGNAL('triggered()') , self , SLOT('DrawADCLine()') )
		connect( @f.actionBrezenhem , SIGNAL('triggered()') , self , SLOT('DrawBrezenhemLine()') )
	end
end
