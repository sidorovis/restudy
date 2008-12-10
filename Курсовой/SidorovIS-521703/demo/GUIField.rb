
=begin
	class GUIField
	slots onTimer()
		what we should do on timer
	signals myTimer()
		that signals retranslate timer signal to football players
=end
class GUIField < Qt::Widget
	attr_reader :speed, :timer
	slots 'onTimer()'
	signals 'myTimer()'
	@@inst = nil
	attr_reader :players, :err, :match_end_label
=begin
	constructor function
		parent (parent widget == field)

		set $field like self
		set @players array
		run place_command function that was written by user
		adding ball to play
=end
		
	def initialize( parent = nil )
		super(parent)
		$field = self
		@players = []
		@timer = Qt::Timer.new( self )
		@err = false
		unless place_commands( $a , $settings.place )
			puts " !!! Ошибка при попытке расстановки комманд (неверные параметры)".to_left()
			@err = true
		end
		addBall()
		connect( @timer, SIGNAL('timeout()'), self, SLOT('onTimer()') )
	end
=begin
	function of match end (str)
		str will be showed on status bar
		stop timer, set label to unrunnable variant		
=end
	def match_end(str)
		@match_end_label = true
		@timer.stop
		parentWidget.setStatus( str )
	end
=begin
	function place_commands( command, yards )
		decide who of the command protecotr or attacker
		place command
=end
	def place_commands( command, yards )
		return false unless command.class == Command
		return false if yards < -40 || yards > 40 || yards % 10 != 0
		field = $field
		if command == $a 
			c1, c2 = $a, $b
		else
			c1, c2 = $b, $a
		end
		if c1.mode == :Attacker
			c1.mode = :Attacker
			c2.mode = :Protector
		else
			c2.mode = :Attacker
			c1.mode = :Protector
		end
		place_command( c1, yards )
		place_command( c2, yards )
		true
	end
=begin
	fucntion dot_inside?(x, y) 
		x, y dot <int> values
			does dot on field
=end
	def dot_inside?( x , y )
		return false if x < 4
		return false if y < 4
		return false if x > size.width - 4
		return false if y > size.height - 4
		true
	end
=begin
	function findByInfo( info )
		input: info ( class Player see Player.rb )
			fiind player by its info 
=end                     
	def findByInfo( info )
		@players.each { |i| return i if i.info == info }
		nil
	end
=begin
	function addPlayer( info, x, y, type )
		input: 	info (class Player see Player.rb)
				x, y = start coordinates <int value>
				type = player type (object of all type you want to connect player with role
			create new GUIPlayer object (with input params)
=end
	def addPlayer(info, x, y, type)
		@players.push(GUIPlayer.new( self, info, x, y, type ))
	end
=begin
	function onTimer()
		what should we do on timer
=end
	def onTimer()
		Thread.critical = true
		@players.each { |player| player.timeout() }
		$ball.timeout()
		Thread.critical = false
	end
=begin
	function addBall
		create $ball from GUIBall class see GUIBall.rb
=end
	def addBall()
		$ball = GUIBall.new( self, @players.last )
	end
=begin
	function paintEvent( pe )
		pe QPaintEvent : standart Qt Paint function
=end
	def paintEvent( pe )
		@pa = Qt::Painter.new( self )
			@pa.fillRect( Qt::Rect.new( 0,0, size.width, size.height ) , Qt::Brush.new( Qt::Color.new(71,193,62) ))
			pen = Qt::Pen.new( Qt::Color.new(255,255,255) )
			pen.setStyle( Qt::SolidLine )
			pen.setWidth( 3 )
			@pa.pen = pen
			@pa.drawLine( 4,4 , 4 , size.height-4 )
			@pa.drawLine( 4,size.height-4 , size.width-4 , size.height-4 )
			@pa.drawLine( 4 , 4 , size.width-4 , 4 )
			@pa.drawLine( size.width-4 ,4 , size.width-4 , size.height-4 )
			pen.setWidth( 2 )
			@pa.pen = pen
			@pa.drawLine( 4 , 4+(size.height-4)/2 , size.width-4 , 4+(size.height-4)/2  )
			@pa.drawLine( 4 + 10* $field_size_k , size.height-4 , 4 + 10* $field_size_k , 4 )
			@pa.drawLine( 4 + 100* $field_size_k , size.height-4 , 4 + 100* $field_size_k , 4 )
			pen.setWidth( 1 )
			@pa.pen = pen
			for i in (1..17)
				@pa.drawLine( 4 + (5*i+10)* $field_size_k, size.height-4 , 4 + (5*i+10)* $field_size_k , 4 )
			end
			pen.setWidth( 3 )
			@pa.pen = pen
			@pa.drawLine( 4 + (5*9+10)* $field_size_k, size.height-4 , 4 + (5*9+10)* $field_size_k , 4 )
			@pa.end
		@pa = nil
	end
end
