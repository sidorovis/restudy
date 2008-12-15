require 'Lab3'

class GraphWindow

	slots 'CreateConvex()', 'Fill()',
			'justDrawConvex()', 'justFill()'

	alias :old4_connectActions :connectActions
private
=begin
	функция find_lowest находит нижнюю точку среди массива
	входные параметры массив точек m среди которых требуется найти минимальную нижнюю по значению y
	выходные параметры индекс точки в входном массиве
=end
	def find_lowest( m )
		y_min = m[0][1]
		di = 0;
		for i in 0..m.size-1 do
			di,y_min = i,m[i][1] if m[i][1] < y_min
		end
		di
	end
=begin
	функция find_lowest находит следующую точку в выпуклой оболочке
	входные параметры 
				массив точек m среди которых требуется найти следующую точку в выпуклюй оболочке
				ci индекс текущей точки в выпуклой оболочке
				dots точки учавствующие в выпуклой оболочке
				f начальная точка
	выходные параметры 
				индекс точки в входном массиве
=end
	def find_next(m,ci,dots,f)
		x0, y0 = m[ci][0], m[ci][1]
		if dots.size == 1						# если пока найдена только одна точка выпуклой оболочки (ВО) то
			m.delete_at(ci)						# удаляем текущую точку ВО
			n = m.sort { |d1,d2| Math::atan2( d2[1]-y0, d2[0]-x0 ) <=> Math::atan2( d1[1]-y0, d1[0]-x0 )}
												# сортируем точки по тангенсу угла
			m.insert(ci,[x0,y0])				# возвращаем удалённую текущую точку на место в котором она находилась
			return m.index( n[0] )				# возвращаем индекс точки следующей во входном массиве точек
		end
		ds = dots.size
		a = Math::atan2( dots[ds-1][1] - dots[ds-2][1] , dots[ds-1][0] - dots[ds-2][0] )
		mcopy = Array.new
		m.delete_at(ci)
		m.each { |i| mcopy.push(i) if ((Math::atan2( i[1] - y0 , i[0] - x0 ) <= a) && !(i[1] == y0 && i[0] == x0) ) }
		m.insert(ci,[x0,y0])
		n = mcopy.sort { |d1,d2| Math::atan2( d2[1]-y0, d2[0]-x0 ) <=> Math::atan2( d1[1]-y0, d1[0]-x0 )}
		mcopy.insert(ci,[x0,y0])
		return m.index(f) if n.empty?
		return m.index( n[0] )
	end
public	
	def justDrawConvex(m)
		mc = m.clone
		return nil if m.size == 0
		if m.size == 1
			justDrawADCLine([[m[0][0],m[0][1]],[m[0][0],m[0][1]]])
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
			justDrawADCLine(m)
		end
		for i in mc
			justDrawDot(i[0],i[1])
		end
	end

	def justFill(m)
		x0, y0 = m[0][0],m[0][1]
		return if @field.key?( [x0,y0] )
		stack = Array.new
		stack.push([x0,y0])
		while (!stack.empty?)
			x, y = stack.last[0], stack.last[1]
			stack.delete_at(stack.size-1)
			if ( !@field.key?([x-1,y]) )
				DrawDot(x-1,y)
				stack.push([x-1,y])
			end
			if ( !@field.key?([x+1,y]) )
				DrawDot(x+1,y)
				stack.push([x+1,y])
			end
			if ( !@field.key?([x,y-1]) )
				DrawDot(x,y-1)
				stack.push([x,y-1])
			end
			if ( !@field.key?([x,y+1]) )
				DrawDot(x,y+1)
				stack.push([x,y+1])
			end
		end
	end

	def CreateConvex
		return unless @paint_mode == :Paint
		StartWorkAction :DrawConvex
	end
	
	def Fill
		return unless @paint_mode == :Paint
		StartWorkAction :Fill
	end

	def connectActions
		old4_connectActions

		@commands[:DrawConvex] = 	[
			:saveWhileMouse,
			:justDrawConvex
									];
		@commands[:Fill] = 	[
			:saveMouse,
			:justFill
								];
		connect( @f.actionCreateConvex, SIGNAL('triggered()') , self , SLOT('CreateConvex()') )
		connect( @f.actionFill , SIGNAL('triggered()') , self , SLOT('Fill()') )
		
	end
end