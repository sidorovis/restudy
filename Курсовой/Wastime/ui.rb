$field_size_k = 8

require 'GUIField'
require 'GUIPlayer'
require 'GUIBall'

class UI < Qt::MainWindow
	signals 'pause()', 'play()'
	slots 'onPause()', 'onPlay()'
	attr_reader :speed
	def initialize()
		super()
		setMinimumSize( 110 * $field_size_k + 5  , 49 * $field_size_k +5 )
		setMaximumSize( 110 * $field_size_k + 5, 49 * $field_size_k +5 )
		windowTitle = "Wastime"
		setStatusBar( Qt::StatusBar.new )
		@label = Qt::Label.new
		$field = GUIField.new(self)
		setCentralWidget($field)
		statusBar.addWidget( @label )
		statusBar.setSizeGripEnabled( false )
		@speed = 10
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
		$field.timer.start( 1000.0 / @speed )
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
		$field.timer.start( 1000.0 / @speed )
		setStatus( "Game going with speed #{@speed}." )
	end
	def keyReleaseEvent( ke )
		spacePressed if ke.key == Qt::Key_Space
		(@speed+=1;retimer) if @speed < 20 && ke.key == Qt::Key_Plus
		(@speed-=1;retimer) if @speed > 0 && ke.key == Qt::Key_Minus
	end
end
