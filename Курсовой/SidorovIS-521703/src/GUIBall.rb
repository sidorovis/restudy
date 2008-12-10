require 'Qt'

=begin
	class GUIBall
	slots timeout()
		on time out redraw ball
=end
class GUIBall < Qt::Widget
	slots 'timeout()'
=begin
	GUI sizes of ball
=end
	@@size_x, @@size_y = $ball_size, $ball_size
	attr_accessor :mode, :player
	attr_accessor :xx, :yy
=begin
	constructor function
		parent (parent widget == field)
		player (player that have ball at start of match)
=end
	def initialize( parent, player )
		super( parent )
		@player = player
		@mode = :Player
	end
=begin
	function timeout()
		what we shoold do on timeout (repainter)
=end
	def timeout()
		fly2() if @mode == :Fly
	end
=begin
	function flyFT
		x, y : from int coordinates
		x2, y2 : to int coordinates
=end
	def flyFT(x,y,x2,y2)
		@mode = :Fly if @mode == :Player
		@xx, @yy = x, y
		@x2, @y2 = x2, y2
	end
=begin
	function fly2()
		if mode == :Fly then replace, redraw ball
=end
	def fly2()
		if @mode == :Fly
			dx, dy = @x2 - @xx, @y2 - @yy
			len = lengthOfVector( dx , dy )
			s = $ball_speed
			dx = dx * 1.0*s / len
			dy = dy * 1.0*s / len
			l1 = lengthOfVector(dx , dy)
			l2 = lengthOfVector(@x2-@xx, @y2-@yy)
			if l1 < l2
				putBall( @xx + dx, @yy + dy )
			else
				putBall( @x2, @y2 )
			end
			repaint
		end
	end
=begin
	function putBall(x, y) 
		x, y where putMyself <int> coordinates
		function that translate coordinates from game system to UI system
=end
	def putBall(x,y)
		@xx, @yy = x,y
		setGeometry( 4 + (5*9+10)* $field_size_k - @@size_x/2 + @xx, 4+ (23.5)* $field_size_k-@@size_y/2 - @yy, @@size_x , @@size_y )
	end
=begin
	function paintEvent( pe )
		pe QPaintEvent : standart Qt Paint function
=end
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