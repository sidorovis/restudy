
class GUIPlayer < Qt::Widget
	slots 'timeout()'
	@@size_x, @@size_y = 1.0*16, 1.0*16
	attr_reader :x, :y, :info
	attr_accessor :ball_mode, :mode
	def initialize( father, info)
		super( father )
		@info = info
		@ball_mode = false
		@mode = :Go
		@show_mode = :show
		@x, @y = 1.0*0,1.0*0
		putPlayer(@x,@y)
	end
	def putPlayer(x,y)
		@x, @y = x,y
		setGeometry( 4 + (5*9+10)* $field_size_k - @@size_x/2 + @x, 4+ (23.5)* $field_size_k-@@size_y/2 - @y, @@size_x , @@size_y )
	end
	def timeout()
		getBallIfPossible if @mode == :waitPass
		action()
	end
	def action()
		if @ball_mode
			pass_to = rand( @info.command.players.size ) 
			makePass( $field.find_player( @info.command.players[ pass_to ]) ) if (  @ball_mode && rand() < 0.15 && pass_to != @info.command.players.index(@info))
		end
		go( rand()*4000-2000,rand()*4000-2000 ) if (@mode != :waitPass)
	end
	def getBallIfPossible
		if ($ball.x == x && $ball.y == y)
			$ball.mode = :Player 
			@mode = :Go
			@ball_mode = true
		end
	end
	def init_ball()
		@ball_mode = true
	end
	def go(x,y)
		dy, dx = y - @y, x - @x
		speed = 1.0 * @info.speed
		len = ((1.0*dx)**2+(1.0*dy)**2)**(0.5)
		dx = dx * 1.0*speed / len
		dy = dy * 1.0*speed / len
		l1 = ((dx)**2+(dy)**2)**(0.5)
		l2 = ((x-@x)**2+(y-@y)**2)**(0.5)
		if l1 < l2
			putPlayer( @x + dx, @y + dy ) #if $field.inside( @x + dx, @y + dy )
		else
			putPlayer( x, y ) #if 	$field.dot_inside?( x, y )
		end
	end
	def makePass( player )
		return unless @ball_mode
		@ball_mode = false
		player.mode = :waitPass
		$ball.flyFT( x, y, player.x, player.y )
	end
	def paintEvent( pe )
		return if @show_mode == :hide
		@pa = Qt::Painter.new( self )
		color = @info.command.color
		color = Qt::Color.new(255,255,0) if @ball_mode
		@pa.setBrush( Qt::Brush.new( color ) )
		@pa.drawEllipse( 1,1, @@size_x - 2 , @@size_y - 2 )
		@pa.end
		@pa = nil
	end
end
