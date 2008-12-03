
class GUIPlayer < Qt::Widget
	slots 'timeout()'
	@@size_x, @@size_y = $player_size, $player_size
	attr_reader :x, :y, :info
	attr_accessor :ball_mode, :mode
	def initialize( father, info, x , y, type )
		super( father )
		@info = info
		info.type = type
		@ball_mode = false
		@mode = :Go
		@show_mode = :show
		@x, @y = x * 1.0, y * 1.0
		setToolTip( "Name: "+ info.name.trans()+"\n Type: "+type.to_s+"\n Speed: "+@info.speed.to_s )
		putPlayer(@x,@y)
	end
	def putPlayer(x,y)
		@x, @y = x,y
		setGeometry( $field_size_k/2+(5*9+10)* $field_size_k - @@size_x/2 + @x, $field_size_k/2+(23.5)* $field_size_k-@@size_y/2 - @y, @@size_x , @@size_y )
	end
	def timeout()
		@i_make_action = false
		what_to_do( self )
	end
	def getBallIfPossible
		return if @i_make_action
		if ( $ball.x == x && $ball.y == y )
			@i_make_action = true
			$ball.mode = :Player 
			@mode = :Go
			@ball_mode = true
		end
	end
	def init_ball()
		@ball_mode = true
	end
	def go2Zone()
		x = 5 + $field_size_k*(50) if info.command.mode == :Attacker
		x = 5 - $field_size_k*(50) unless info.command.mode == :Attacker
		y = @y
		go(x, y)
	end
	def go(x,y)
		return if mode == :waitPass || @i_make_action
		@i_make_action = true
		dy, dx = y - @y, x - @x
		speed = 1.0 * @info.speed
		len = lengthOfVector(dx,dy)
		dx = dx * 1.0*speed / len
		dy = dy * 1.0*speed / len
		l1 = lengthOfVector( dx, dy )
		l2 = lengthOfVector( x-@x, y-@y )
		if l1 < l2
			x2, y2 = test2Put( @x + dx , @y + dy)
			putPlayer( x2, y2 )
		else
			x2, y2 = test2Put( x , y )
			putPlayer( x2, y2 )
		end
	end
	def test2Put( x , y )
		x1, y1, x2, y2 = @x, @y, x, y
		xpf, ypf = x, y
		full_len = lengthOfVector(x2-x1,y2-y1)
		players = $field.players
#puts "----------------------------------------------------  "+players.size.to_s
		for player in players
			x3, y3 = player.x, player.y
			next if x3 == x1 && y3 == y1
			a1, b1, c1 = makeLineParams(x1,y1,x2,y2)
			d = ((a1*x3+b1*y3+c1) / (a1**2+b1**2)**0.5).abs
			next if d >= $player_size
			l = ($player_size**2-d**2)**0.5
			a2, b2= -b1, a1
			c2 = -a2*x3-b2*y3
			xp, yp = crossDotByParams(a1,b1,c1,a2,b2,c2)
			next if ( xp.nan? || yp.nan? )
			a = Math.atan2(y2-y1,x2-x1)
			xp -= l*Math.cos(a)
			yp -= l*Math.sin(a)
			xp = (( xp * 100000000 ).round)*0.00000001
			yp = (( yp * 100000000 ).round)*0.00000001
			if ( (( xp >= x1 && xp <= x2 ) || ( xp <= x1 && xp >= x2 ))&&
				 (( yp >= y1 && yp <= y2 ) || ( yp <= y1 && yp >= y2 ))&&
				 lengthOfVector(xp-x1,yp-y1) < full_len )
				 xpf, ypf = xp, yp
				 full_len = lengthOfVector(xp-x1,yp-y1)
			end
		end
		return xpf,ypf
	end
	def makePass( player )
		return if @i_make_action
		return unless @ball_mode
		@i_make_action = true
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
