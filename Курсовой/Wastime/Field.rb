
require 'Player'

class Field < Qt::Widget
	attr_reader :speed
	attr_reader :timer
	slots 'onTimer()'
	@@inst = nil
	attr_reader :players
	def self.inst( parent = nil )
		unless @@inst
			@@inst = Field.new( parent )
		end
		@@inst
	end
private
	def initialize( parent )
		super parent 
		@players = []
		@timer = Qt::Timer.new( self )

		players = $settings.commands[ $settings.commands.keys[0] ][:Players]

#		puts players[ players.keys[0] ][:Speed]
		addPlayer( players[ players.keys[0]] , 10, 150, :First)
		addPlayer( players[ players.keys[1]] , 250 , 10, :Second)
		addPlayer( players[ players.keys[2]] , -150 , -100, :Second)
		
		addBall()
		
		@players.last.ball_mode = true
	end
public
	def addPlayer(player_info, x, y, command_number = :First)
		@players.push Player.new( self, player_info, command_number, x, y )
		connect( @timer, SIGNAL('timeout()'), @players.last, SLOT('timeout()') )
	end
	def addBall()
		@ball = Ball.inst( self, @players.last )
		connect( @timer, SIGNAL('timeout()'), @ball, SLOT('timeout()') )
	end
	def paintEvent( pe )
		@pa = Qt::Painter.new( self )
		@pa.fillRect( Qt::Rect.new(Qt::Point.new(0,0), size ) , Qt::Brush::new( Qt::Color::new(71,193,62) ))
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
