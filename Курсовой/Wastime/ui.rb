
require 'GUIField'
require 'GUIPlayer'
require 'GUIBall'


class UI < Qt::MainWindow
	signals 'pause()', 'play()'
	slots 'onPause()', 'onPlay()'
	attr_reader :speed
	attr_reader :err
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
	def setStatus(text)
		@label.setText( text )
		repaint
	end
	def onPause()
		@mode = :Pause
		$field.timer.stop()
		setStatus( "Game Paused. Press Space..." )
	end
	def onPlay()
		@mode = :Play
		$field.timer.start( $max_time_period / @speed )
		setStatus( "Game going with speed #{@speed}." )
	end
	def spacePressed()
		if @mode == :Play
			emit pause
		else
			emit play
		end
	end
	def retimer()
		$field.timer.stop()
		$field.timer.start( $max_time_period / @speed )
		setStatus( "Game going with speed #{@speed}." )
	end
	def keyReleaseEvent( ke )
		spacePressed if ke.key == Qt::Key_Space
		(@speed-=1;retimer) if @speed > $min_speed && ke.key == Qt::Key_Minus
		(@speed+=1;retimer) if @speed < $max_speed && ke.key == Qt::Key_Plus
	end
end
