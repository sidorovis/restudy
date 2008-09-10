require 'Qt'
=begin
	class GraphWindow
	about: This class create field to draw dots on monitor emulation field
=end
class GraphWindow < Qt::MainWindow
protected
=begin
	method paintEvent
	in: QPaintEvent e, standart input parameter
	out: nil
	about: draw field on window form
=end
	def paintEvent(e)
		@pa = Qt::Painter.new( self )
		x, y = @X + @dx, @Y - @dy		#	x, y sending
		@pa.fillRect( -1 , -1 , @X * 2 + 1 , @Y * 2 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
		@pa.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
		for i in (-1000..1000)	#	draw blue lines		
			@pa.drawLine( -1000 , y + (i * @cell_size * @z) , 1000 , y + (i * @cell_size * @z) )
			@pa.drawLine( x + (i * @cell_size * @z) , -1000 , x + (i * @cell_size * @z) , 1000 )
		end
		@pa.save
		DrawAlgorythm()	#draw algorithm
		@pa.restore
		@pa.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
		@pa.drawLine( x , -10000 , x , 10000 )	# draw Y line
		@pa.drawLine( -10000 , y , 10000 , y )	# draw X line
		@pa.end
		@pa = nil
	end
=begin
	method keyReleaseEvent
	in: QKeyReleaseEvent e, standart input parameter, that describe key release event
	out: nil
	about: gave posibilities of zooming and moving graphic
=end
	def keyReleaseEvent(e)
		@dx -= 10*@z if (e.key == 16777234)	#	left button released
		@dy += 10*@z if (e.key == 16777235)	#	right button released
		@dx += 10*@z if (e.key == 16777236)	#	up button released
		@dy -= 10*@z if (e.key == 16777237)	#	down button released
		@z *= 1.2 if (e.key == 42)	#	"/" button released
		@z /= 1.2 if (e.key == 47)	#	"*"	button released
		repaint()
	end
=begin
	method DrawDot
	in: x, y coordinates of dot on field
	out: nothing
	about: draw dot on field
=end
	def DrawDot(x,y)
		cx, cy = @X + @dx, @Y - @dy
		@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0) )
		@pa.drawRect(cx + (x)*@cell_size*@z ,cy - (y+1)*@cell_size*@z, @cell_size*@z , @cell_size*@z)
	end
public
=begin
	method initialize
	in: half_size_x, half_size_y set size of field
	out: object of GraphWindow
	about: constructor
=end
	def initialize( half_size_x = 400, half_size_y = 300 )
		super()
		@X, @Y, @dx, @dy, @z, @cell_size, @pa = half_size_x, half_size_y, 0, 0, 1, 15, nil
		setMinimumSize( @X * 2, @Y * 2)
		setWindowTitle("Graphics")
		show
	end
=begin
	method DrawAlgorythm
	in: 
	out: 
	about: draw algorythm template
=end	
	def DrawAlgorythm()
		DrawDot(0,0)
		DrawDot(0,1)
		DrawDot(1,0)
		DrawDot(3,3)
	end
end
