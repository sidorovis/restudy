require 'Qt'

class GUIBall < Qt::Widget
	slots 'timeout()'
	@@size_x, @@size_y = 8, 8
	@@ball = nil
	attr_accessor :mode
	attr_reader :x, :y
	def initialize( parent, player )
		super( parent )
		@player = player
		@mode = :Player
	end
	def timeout()
		fly2() if @mode == :Fly
	end
	def flyFT(x,y,x2,y2)
		@mode = :Fly if @mode == :Player
		@x, @y = x, y
		@x2, @y2 = x2, y2
	end
	def fly2()
		if @mode == :Fly
			dx, dy = @x2 - @x, @y2 - @y
			len = ((1.0*dx)**2+(1.0*dy)**2)**(0.5)
			s = 16
			dx = dx * 1.0*s / len
			dy = dy * 1.0*s / len
			l1 = ((dx)**2+(dy)**2)**(0.5)
			l2 = ((@x2-@x)**2+(@y2-@y)**2)**(0.5)
			if l1 < l2
				putBall( @x + dx, @y + dy )
			else
				putBall( @x2, @y2 )
			end
		end
	end
	def putBall(x,y)
		@x, @y = x,y
		setGeometry( 4 + (5*9+10)* $field_size_k - @@size_x/2 + @x, 4+ (23.5)* $field_size_k-@@size_y/2 - @y, @@size_x , @@size_y )
	end
	def paintEvent( pe )
		@pa = Qt::Painter.new( self )
		if @mode == :Fly
			color = Qt::Color.new(0,0,0)
			@pa.setBrush( Qt::Brush.new( color ) )
			@pa.drawEllipse( 1,1, @@size_x - 2 , @@size_y - 2 )
		end
		if @mode == :Ground
			color = Qt::Color.new(255,255,255)
			@pa.setBrush( Qt::Brush.new( color ) )
			@pa.drawEllipse( 1,1, @@size_x - 2 , @@size_y - 2 )
		end
		@pa.end
		@pa = nil
	end
end