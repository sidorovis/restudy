
class GUIField < Qt::Widget
	attr_reader :speed, :timer
	slots 'onTimer()'
	@@inst = nil
	attr_reader :players
	def initialize( parent = nil )
		super(parent)
		@players = []
		@timer = Qt::Timer.new( self )
		addCommand($a)
		addCommand($b)
		addBall()
		@players.last.init_ball()
	end
	def dot_inside?( x , y )
		return false if x < 4
		return false if y < 4
		return false if x > size.width - 4
		return false if y > size.height - 4
		true
	end
	def find_player( info )
		@players.each { |i| return i if i.info == info }
		nil
	end
	def addCommand( c )
		c.players.each { |player| addPlayer( player ) }
	end
	def addPlayer(info)
		@players.push(GUIPlayer.new( self, info ))
		connect( @timer, SIGNAL('timeout()'), @players.last, SLOT('timeout()') )
	end
	def addBall()
		$ball = GUIBall.new( self, @players.last )
		connect( @timer, SIGNAL('timeout()'), $ball, SLOT('timeout()') )
	end
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
