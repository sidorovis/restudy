require 'main.ui'
=begin
	class GraphWindow
	about: This class create field to draw dots on monitor emulation field
=end
class GraphWindow < Qt::MainWindow
	signals 'getMousePress()', 'endMouseClicking()'
	slots 'translateMousePress()', 'saveWhileMouse()', 'saveMouse()', 'clearScreen()', 'deleteLastAction()', 'stopWhileMouse()'
protected
=begin
	method paintEvent
	in: QPaintEvent e, standart input parameter
	out: nil
	about: draw field on window form
=end
	def paintEvent(e)
		puts size.width
		@pa = Qt::Painter.new( self )
		x, y = @X + @dx, @Y - @dy		#	x, y sending
		@pa.fillRect( -1 , -1 , @X * 10 + 1 , @Y * 10 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
		@pa.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
		for i in (-500..500)	#	draw blue lines		
			@pa.drawLine( -3000 , y + (i * @cell_size * @z) , 3000 , y + (i * @cell_size * @z) )
			@pa.drawLine( x + (i * @cell_size * @z) , -3000 , x + (i * @cell_size * @z) , 3000 )
		end
		@pa.save
		DrawAlgorythm()	#draw algorithm
		@pa.restore
		@pa.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
		@pa.drawLine( x+@z*@cell_size*0.5 , -10000 , x+@z*@cell_size*0.5 , 10000 )	# draw Y line
		@pa.drawLine( -10000 , y-@z*@cell_size*0.5 , 10000 , y-@z*@cell_size*0.5 )	# draw X line
		@pa.end
		@pa = nil
	end
=begin
	method keyReleaseEvent
	in: QKeyReleaseEvent e, standart input parameter, that describe key release event
	out: nil
	about: gave posibilities of zooming and moving graphic
=end
	def keyReleaseEvent(e)
		@dx -= 10*@z if (e.key == 16777234)	#	left button released
		@dy += 10*@z if (e.key == 16777235)	#	right button released
		@dx += 10*@z if (e.key == 16777236)	#	up button released
		@dy -= 10*@z if (e.key == 16777237)	#	down button released
		@z *= 1.2 if (e.key == 42)	#	"/" button released
		@z /= 1.2 if (e.key == 47)	#	"*"	button released
		addedKeyReleaseEvent(e)
		repaint()
	end
	def addedKeyReleaseEvent(e)
	end
=begin
	method DrawDot
	in: x, y coordinates of dot on field
	out: nothing
	about: draw dot on field
=end
	def DrawDot(x,y)
		@field[[x.round,y.round]] = true
	end
	def justDrawDot(x,y)
		return if (x.abs > 10000 || y.abs > 10000)
		cx, cy = (@X + @dx).round, (@Y - @dy).round
		@pa.drawRect(cx + (x.round)*@cell_size*@z ,cy - (y.round+1)*@cell_size*@z, @cell_size*@z , @cell_size*@z)
	end
	def clearScreen()
		@mouse_clicked_to.clear
		@drawCommands.clear
		@field.clear
		repaint
	end
	def deleteLastAction()
		@drawCommands.pop() if @drawCommands.size > 0
		repaint
	end
public
=begin
	method initialize
	in: half_size_x, half_size_y set size of field
	out: object of GraphWindow
	about: constructor
=end
	def initialize( half_size_x = 400, half_size_y = 300 )
		super()
		@field = Hash.new
		@f_y = Array.new
		@f = Ui::MainWindow.new()
		@f.setupUi( self );
		@mouse_clicked_to = Array.new
		@commands = Hash.new
		@drawCommands = Array.new
		@current_command = nil
		@mode = nil
		connect( @f.actionClear_Field, SIGNAL('triggered()'), self, SLOT('clearScreen()') )
		connect( self, SIGNAL('endMouseClicking()'), self, SLOT('stopWhileMouse()') )
		connectActions()
		@X, @Y, @dx, @dy, @z, @cell_size, @pa = half_size_x, half_size_y, 0, 0, 1, 5, nil
		setWindowTitle("Graphics")
		show
	end
=begin
	method DrawAlgorythm
	in: 
	out: 
	about: draw algorythm template
=end
	def DrawAlgorythm()
#		dot_array = [ [0,0], [10,0], [0,15] ]
#		justDrawEllipse(dot_array)

		puts "\n\n\n\n\n\n\n\t\t\t\t\t  Start Drawing" if $log
		puts "-----------------------------" if $log
		@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0,255) )
		for i in @mouse_clicked_to
			justDrawDot(i[0],i[1]);
		end
		for i in @drawCommands
			self.send(i[0],i[1])
		end
		@drawCommands.clear();
		@field.each { |x,y| justDrawDot(x[0],x[1]) }
		puts "\t\t\t\t\t  Stop Drawing" if $log
		puts "-----------------------------\n\n\n\n\n\n\n" if $log
	end
	def connectActions()
	end
# ������� ������ �������
	def clearCommandList()
		@mouse_clicked_to.clear()
		@current_command = 0
		@mode = nil
		self.disconnect(SIGNAL('getMousePress()'));
#		puts 'ccl '+@mouse_clicked_to.size.to_s
	end
# ��������� ���������� ����	� ������ ������
	def saveMouse()
		return unless @mode
		@mouse_clicked_to.push( [@mouse_x, @mouse_y] )
		@current_command += 1
        clearCommandList() if ( !@mode || !@current_command || !@commands[@mode] || !@commands[@mode][@current_command] )
		if ( @commands[@mode][@current_command] && @commands[@mode][@current_command] != :saveMouse )
			@drawCommands.push( [ @commands[@mode][@current_command], @mouse_clicked_to.clone ] )
			clearCommandList()
		end
		repaint()
#		puts 'sm '+@mouse_clicked_to.size.to_s
	end
	def saveWhileMouse()
		return unless @mode
		@mouse_clicked_to.push( [@mouse_x, @mouse_y] )
		repaint()
	end
	def stopWhileMouse()
		return unless @mode
		@current_command += 1
		@drawCommands.push( [ @commands[@mode][@current_command], @mouse_clicked_to.clone ] )
		clearCommandList()
		repaint()
	end
	def mouseReleaseEvent(e)
		if (e.button == 1)
			@mouse_x, @mouse_y = e.x, e.y
			translateMousePress()
			emit getMousePress()
		end
		if (e.button == 2)
			emit endMouseClicking()
		end
	end
	def translateMousePress()
		x, y = ( (@mouse_x - @X - @dx +0.5)*1.0/(@z*@cell_size) ), ( (@Y - @dy  - @mouse_y -0.5)*1.0/(@z*@cell_size) )
		@mouse_x, @mouse_y = x.floor, y.floor
	end
# ������� �������������� ������� ������ � ����
	def StartWorkAction(mode)
		@mode, @current_command = mode, 0
		@mouse_clicked_to.clear
		self.disconnect(SIGNAL('getMousePress()'));
		connect( self, SIGNAL('getMousePress()'), self, SLOT( @commands[@mode][@current_command].id2name+'()' ) )
#		puts 'swa '+@mouse_clicked_to.size.to_s
	end
end
