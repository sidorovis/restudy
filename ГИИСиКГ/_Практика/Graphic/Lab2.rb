require 'Lab1'

class GraphWindow

	slots 'DrawEllipse()', 'justDraw2DimensionLine()'
	
  private
	def len(x0,y0,x1,y1)
		(((y0 - y1)**2 + (x0 - x1)**2)*1.0)**(1.0/2)
	end
	def f(tx,x0,ty,y0,r1,r2)
		(( (((tx-x0)*1.0) **2)/(r1**2)+(((ty-y0)*1.0)**2)/(r2**2) ) - 1).abs
	end
	def DrawMirroredDot(x,y,x0,y0)
		print " x= #{x}     y= #{y}  \n";
		DrawDot(x,y)
		DrawDot(x  ,y0 - ( y - y0))
		DrawDot(x0 - (x - x0) ,y )
		DrawDot(x0 - (x - x0) ,y0 - ( y - y0))
	end
  public
	def justDraw2DimensionLine(m)
		puts "--------------------------------------"	if $log
		x0, y0, x1, y1, x2, y2 = m[0][0], m[0][1], m[1][0], m[1][1], m[2][0], m[2][1]
		m1,m2,m3 = Array.new, Array.new, Array.new
		r1 = len(x0,y0,x1,y1)
		r2 = len(x0,y0,x2,y2)
		print " a = ",r1,"   b = ",r2,"\n" # if $log
		x = x0
		y = (y0 + r2).to_i
		DrawMirroredDot(x,y,x0,y0)
		while (y > y0)
			d1 = f(x+1, x0, y, y0, r1, r2)
			d2 = f(x+1, x0, y-1, y0, r1, r2)
			d3 = f(x, x0, y-1, y0, r1, r2)
			print d1," ",d2," ",d3,"\n"		if $log
			if ( d1 < d2 && d1 < d3)
				x = x + 1 
			else
				if ( d2 < d1 && d2 < d3)
					x, y = x+1, y-1
				else
					y = y - 1
				end
			end
			DrawMirroredDot(x,y,x0,y0)
		end
		puts "--------------------------------------"	if $log
	end

	def DrawEllipse()
#		def self.f(tx,x0,ty,y0,r1,r2)
#			(( (((tx-x0)*1.0) **2)/(r1**2)+(((ty-y0)*1.0)**2)/(r2**2) ) - 1).abs
#		end
		StartWorkAction :DrawEllipse
	end

	alias :old2_connectActions :connectActions
	def connectActions
		old2_connectActions
		
			@commands[:DrawEllipse] = 	[
					:saveMouse,
					:saveMouse,
					:saveMouse,
					:justDraw2DimensionLine
										];
		connect( @f.actionEllipse, SIGNAL('triggered()') , self , SLOT('DrawEllipse()') )
		
	end
end