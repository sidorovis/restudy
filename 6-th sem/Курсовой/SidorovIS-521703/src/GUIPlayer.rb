=begin
	class GUIPlayer
	slots timreout()
		what we should do on timer
=end
class GUIPlayer < Qt::Widget
	slots 'timeout()'
	@@size_x, @@size_y = $player_size, $player_size
	attr_reader :info, :xx, :yy
	attr_accessor :ball_mode, :mode
=begin
	constructor function
		input:
			father : father frame (GUIField see GUIField.rb>
			info : PLayer.class see Player.rb
			x, y start coordinates <int value>
			type : player role
=end
	def initialize( father, info, x , y, type )
		super( father )
		@info = info
		info.type = type
		@ball_mode = false
		@mode = :Go
		@show_mode = :show
		@xx, @yy = 1.0*x, 1.0*y
		setToolTip( "Name: "+ info.name.trans()+"\n Type: "+type.to_s+"\n Speed: "+@info.speed.to_s )
		putPlayer(x,y)
	end
=begin
	function translate( x, y)
		traslate coordinates from out coordinate system to UI
=end
	def translate( x , y )
		return $field_size_k/2+(5*9+10)* $field_size_k - @@size_x/2 + x, $field_size_k*24-@@size_y/2 - y
	end
=begin
	function putPlayer(x, y )
		put player widget to x,y position
=end
	def putPlayer(x,y)
		@xx, @yy = x,y
		x, y = translate(x,y)
		setGeometry( x, y, @@size_x , @@size_y )
	end
=begin
	function attack player
		player: GUIPlayer
		try to attack player
=end
	def attack( player )
		return if lengthOfVector( player.xx - xx, player.yy - yy) > $player_size*2
		player.ball_mode = false
		$ball.mode = :Ground
		$ball.putBall($ball.player.xx, $ball.player.yy)
		$ball.player = nil
		$field.match_end( " Ìÿק םא ןמכו!" )
		$field.repaint
	end
=begin
	function timeout()
		what player should do on his move
		run researcher function what_to_do
=end
	def timeout()
		@i_make_action = false
		what_to_do( self )
	end
=begin
	function getBallIfPossible
		if there are exist possibility than player get ball
=end
	def getBallIfPossible
		return if @i_make_action
		if ( $ball.xx == xx && $ball.yy == yy )
			@i_make_action = true
			$ball.mode = :Player 
			$ball.player = self
			@mode = :Go
			@ball_mode = true
		end
	end
=begin
	function init_ball
	gave ball to player
=end
	def init_ball()
		@ball_mode = true
	end
=begin
	function go2Zone
		send player to zone on his shortiest way
=end
	def go2Zone()
		x = 5 + $field_size_k*(50) if info.command.mode == :Attacker
		x = 5 - $field_size_k*(50) unless info.command.mode == :Attacker
		y = @yy
		go(x, y)
	end
=begin
	function go4 player
		input:
			player class GUIPlayer 
		
		    send nyself to follow player
=end
	def go4( player )
#		go2Zone()
		go( player.xx , player.yy )
	end
=begin
	fucntion go(x, y)
		input:
			x, y coordinates where player shoould go by his own speed
=end
	def go(x,y)
		return if mode == :waitPass || @i_make_action
		@i_make_action = true
		dy, dx = y - @yy, x - @xx
		speed = 1.0 * @info.speed
		len = lengthOfVector(dx,dy)
		dx = dx * 1.0*speed / len
		dy = dy * 1.0*speed / len
		l1 = lengthOfVector( dx, dy )
		l2 = lengthOfVector( x - @xx, y - @yy )
		if l1 < l2
			x2, y2 = test2Put( @xx + dx , @yy + dy)
			putPlayer( x2, y2 )
		else
			x2, y2  = test2Put( x , y )
			putPlayer( x2, y2 )
		end
	end
=begin
    function fingers()
		return array of players that close to our player than 4* player_size
=end
	def fingers( )
		a = []
		for player in $field.players
			if (lengthOfVector( xx - player.xx, yy-player.yy ) < $player_size*4)
				a.push player
			end
		end
		a
	end
=begin
	fucntion test2Put
		input:
			x,y coordinates where we decide to place player
				function check player can he go to that point or not
=end
	def test2Put( x , y )
		x1, y1 = @xx, @yy 	# translate( @x , @y ) 
		x2, y2 = x, y 		# translate( x , y ) 
		return x1, y1 if x == x1 && y == y1
		xpf, ypf = x, y
		full_len = 100+lengthOfVector(x2-x1,y2-y1)
		players = $field.players
	if $llog
		for player in players
			next if player == self
			player_size = $player_size
			player_size /= 1.5 if player.info.command == info.command
			x3, y3 = player.xx, player.yy
			a1, b1, c1 = makeLineParams(x1,y1,x2,y2)
			d = (((a1*x3)+(b1*y3)+(c1)) / (Math::sqrt(a1**2+b1**2))).abs
			next if d > (player_size)
			l = Math::sqrt((player_size)**2-(d**2))
			a2, b2= b1, -a1
			c2 = -a2*x3-b2*y3
			xp, yp = crossDotByParams(a1,b1,c1,a2,b2,c2)
			if ( !((( xp >= x1 && xp <= x2 ) || ( xp <= x1 && xp >= x2 ))&&
				 (( yp >= y1 && yp <= y2 ) || ( yp <= y1 && yp >= y2 ))))
				next
			end
			a = Math::atan2( y2-y1 , x2-x1 )
			len = lengthOfVector( xp-x1 , yp-y1 ) - l
			dx , dy = len*Math::cos(a), len*Math::sin(a)
			xp = x1 + dx
			yp = y1 + dy
			if ( ((( xp >= x1 && xp <= x2 ) || ( xp <= x1 && xp >= x2 ))&&
				 (( yp >= y1 && yp <= y2 ) || ( yp <= y1 && yp >= y2 )) || len < 0 )&&
				 lengthOfVector(xp-x3,yp-y3) < full_len )
				 xpf, ypf = xp, yp
				 full_len = lengthOfVector(xp-x3,yp-y3)
			end
		end
	end
#		puts "fi "+Time.now.to_f.to_s
		return xpf,ypf
	end
=begin
	function makePass
		input: player
			player GUIPlayer
			send pass (ball) to player
=end
	def makePass( player )
		return if @i_make_action
		return unless @ball_mode
		@i_make_action = true
		@ball_mode = false
		player.mode = :waitPass
		$ball.flyFT( xx , yy , player.xx , player.yy )
	end
=begin
	function paintEvent( pe )
		pe QPaintEvent : standart Qt Paint function
=end
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
