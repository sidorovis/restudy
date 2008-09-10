require 'Qt'

class GraphWindow < Qt::MainWindow
protected
	def paintEvent(e)
		pa = Qt::Painter.new( self )
		@pa = pa
		x = @X + @dx
		y = @Y - @dy
		pa.fillRect( -1 , -1 , @X * 2 + 1 , @Y * 2 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))
		
		pa.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
		(-1000..1000).each { |i| pa.drawLine( -1000 , y + (i * @cell_size * @z), 1000 , y + (i * @cell_size * @z) ) }
		(-1000..1000).each { |i| pa.drawLine( x + (i * @cell_size * @z) , -1000 , x + (i * @cell_size * @z) , 1000 ) }
		pa.save
		DrawAlgorythm()
		pa.restore
		pa.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
		pa.drawLine( x , -10000 , x , 10000 )
		pa.drawLine( -10000 , y , 10000 , y )

		pa.end
		@pa = nil
	end
	def keyReleaseEvent(e)
#		print e.key
		@dx -= 10*@z if (e.key == 16777234)
		@dy += 10*@z if (e.key == 16777235)
		@dx += 10*@z if (e.key == 16777236)
		@dy -= 10*@z if (e.key == 16777237)
		@z *= 1.2 if (e.key == 42)
		@z /= 1.2 if (e.key == 47)
		repaint()
	end
	def DrawDot(x,y)
		cx = @X + @dx
		cy = @Y - @dy
		@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0) )
		@pa.drawRect(cx + (x)*@cell_size*@z ,cy - (y+1)*@cell_size*@z, @cell_size*@z , @cell_size*@z)
	end
public
	def initialize( half_size_x = 400, half_size_y = 300 )
		super()
		@X, @Y, @dx, @dy, @z = half_size_x, half_size_y, 0, 0, 1
		@cell_size = 15
		@pa = nil
		setMinimumSize( @X * 2, @Y * 2)
		setWindowTitle("Graphics");
		show
	end
	def DrawAlgorythm()
		DrawDot(0,0)
		DrawDot(0,1)
		DrawDot(1,0)
		DrawDot(3,3)
	end
end
