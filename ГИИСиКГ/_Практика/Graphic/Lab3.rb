require 'Lab2'
require 'Array2.rb'

class GraphWindow

	slots 'DrawBezieSpline()', 'DrawErmitSpline()', 'DrawBSpline()', 'justDrawSpline()', 'justDrawBSpline()'

	alias :old3_connectActions :connectActions
private
	def create_matrix_ermit
		unless @@m
			@@m = Array2.new
			@@m[1,1],@@m[1,2],@@m[1,3],@@m[1,4]=  2 , -2 ,  1 ,  1 
			@@m[2,1],@@m[2,2],@@m[2,3],@@m[2,4]= -3 ,  3 , -2 , -1 
			@@m[3,1],@@m[3,2],@@m[3,3],@@m[3,4]=  0 ,  0 ,  1 ,  0
			@@m[4,1],@@m[4,2],@@m[4,3],@@m[4,4]=  1 ,  0 ,  0 ,  0
		end
	end
	def create_matrix_bezie
		unless @@m
			@@m = Array2.new
			@@m[1,1],@@m[1,2],@@m[1,3],@@m[1,4]= -1 ,  3 , -3 , 1 
			@@m[2,1],@@m[2,2],@@m[2,3],@@m[2,4]=  3 , -6 ,  3 , 0 
			@@m[3,1],@@m[3,2],@@m[3,3],@@m[3,4]= -3 ,  3 ,  0 , 0
			@@m[4,1],@@m[4,2],@@m[4,3],@@m[4,4]=  1 ,  0 ,  0 , 0
		end
	end
public
	def justDrawSpline(m)
		c = Array2.new
		c[1,1], c[1,2] = m[0][0],m[0][1]
		c[2,1], c[2,2] = m[1][0],m[1][1]
		c[3,1], c[3,2] = m[2][0],m[2][1]
		c[4,1], c[4,2] = m[3][0],m[3][1]
		puts "=============================================="
		puts c
		puts "=============================================="
		shag = 0.001
		puts "==============================================" if $log
		for t_cur in 0..(1 / shag)
			t = t_cur / (1/shag)
			tm = Array2.new
			tm[1,1],tm[1,2],tm[1,3],tm[1,4] = t**3, t**2, t**1, t**0
			res = tm*(@@m*c)
			xd, yd = res[1,1], res[1,2]
			DrawDot( xd, yd)
			puts " x = #{x.round}, y = #{y.round} " if $log
		end
		puts "==============================================" if $log
	end
	def getSplineArray(m)
		c = Array2.new
		answer = Hash.new
		c[1,1], c[1,2] = m[0][0],m[0][1]
		c[2,1], c[2,2] = m[1][0],m[1][1]
		c[3,1], c[3,2] = m[2][0],m[2][1]
		c[4,1], c[4,2] = m[3][0],m[3][1]
		puts "=============================================="
		puts c
		puts "=============================================="
		shag = 0.001
		puts "==============================================" if $log
		for t_cur in (0..(1 / shag))
			t = t_cur / (1/shag)
			tm = Array2.new
			tm[1,1],tm[1,2],tm[1,3],tm[1,4] = t**3, t**2, t**1, t**0
			res = tm*(@@m*c)
			xd, yd = res[1,1], res[1,2]
			answer[t]= [ xd, yd]
#			DrawDot( xd, yd)
			puts " x = #{x.round}, y = #{y.round} " if $log
		end
		puts "==============================================" if $log
		answer
	end
	def justDrawBSpline(m)
		return if m.size < 4
		answer = Hash.new
		size = m.size
		m[size] =   m[0].clone
		m[size+1] = m[1].clone
		m[size+2] = m[2].clone
		for i in (0..m.size-4)
			cm = Array.new
			(0..3).each { |u| cm[u] = Array.new;cm[u][0],cm[u][1] = m[i+u][0],m[i+u][1] }
			a = getSplineArray(cm)

			for key,value in a

=begin
				if answer.key?(key)
					x1 ,y1 = answer[ key ][0],answer[ key ][1]
					x2 ,y2 = value[0],value[1]
					x1 = (x1+x2)/2
					y1 = (y1+y2)/2
					answer[key] = [x1,y1]
				else
=end
					answer[i+key] = value
#				end
			end
		end
		for key,i in answer
			DrawDot( i[0], i[1] )
		end
	end

	def DrawBezieSpline()
		create_matrix_bezie
		StartWorkAction :DrawBezieSpline
	end
	def DrawBSpline()
		create_matrix_bezie
		StartWorkAction :DrawBSpline
	end
	def DrawErmitSpline()
		create_matrix_ermit
		StartWorkAction :DrawBezieSpline
	end

	def connectActions
		old3_connectActions
		
		@commands[:DrawBezieSpline] = 	[
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:justDrawSpline
								];
		@commands[:DrawErmitSpline] = 	[
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:justDrawSpline
								];
		@commands[:DrawBSpline] = 	[
			:saveWhileMouse,
			:justDrawBSpline
								];

		connect( @f.actionPaint_spline, SIGNAL('triggered()') , self , SLOT('DrawBezieSpline()') )
		connect( @f.actionErmit , SIGNAL('triggered()') , self , SLOT('DrawErmitSpline()') )
		connect( @f.actionBspline , SIGNAL('triggered()') , self , SLOT('DrawBSpline()') )
		
	end
end