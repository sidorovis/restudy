
require 'GUIField'
require 'GUIPlayer'
require 'GUIBall'

=begin
	class UI
	slots 
	  onPause()
		what we should do on pause
	  onPlay()
		what we should do on play
	signals
	  pause()
	  	pause signal
	  play()
	    plays signal
=end

class UI < Qt::MainWindow
	signals 'pause()', 'play()'
	slots 'onPause()', 'onPlay()'
	attr_reader :speed
	attr_reader :err
=begin
	constructor function
			create main window
=end
	def initialize()
		super()
		setMinimumSize( $x_field_size * $field_size_k + $additional_xy_size , $y_field_size * $field_size_k +$additional_xy_size )
		setMaximumSize( $x_field_size * $field_size_k + $additional_xy_size , $y_field_size * $field_size_k +$additional_xy_size )
		setWindowTitle( "Wastime" )
		setStatusBar( Qt::StatusBar.new )
		@label = Qt::Label.new
		GUIField.new(self)
		@err = $field.err
		setCentralWidget($field)
		statusBar.addWidget( @label )
		statusBar.setSizeGripEnabled( false )
		@speed = $start_speed
		onPause
		connect( self, SIGNAL('pause()'), self, SLOT('onPause()') )
		connect( self, SIGNAL('play()'), self, SLOT('onPlay()') )
		show
	end
=begin
	function setStatus( text )
		text : String
				set status to main window
=end	
	def setStatus(text)
		@label.setText( text )
		repaint
	end
=begin
	function onPause()
			what we do on pause
=end
	def onPause()
		@mode = :Pause
		$field.timer.stop()
		setStatus( "Game Paused. Press Space..." )
	end
=begin
	function onPlay()
			what we do on play
=end
	def onPlay()
		@mode = :Play
		$field.timer.start( $max_time_period / @speed )
		setStatus( "Game going with speed #{@speed}." )
	end
=begin
	function spacePressed()
			what we do on space
=end
	def spacePressed()
		return if $field.match_end_label
		if @mode == :Play
			emit pause
		else
			emit play
		end
	end
=begin
	fucntion retimer()
			reset timer to new speed value
=end	
	def retimer()
		return if $field.match_end_label
#		puts
		$field.timer.stop()
		$field.timer.start( $max_time_period / @speed )
		setStatus( "Game going with speed #{@speed}." )
	end
=begin
	function keyReleaseEvent( ke )
		input :
			ke : QKeyEvent
				set actions on button pressing
=end
	def keyReleaseEvent( ke )
		spacePressed if ke.key == Qt::Key_Space
		(@speed-=1;retimer) if @speed > $min_speed && ke.key == Qt::Key_Minus
		(@speed+=1;retimer) if @speed < $max_speed && ke.key == Qt::Key_Plus
	end
end
