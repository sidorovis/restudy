require 'main_window.ui'
require 'FullMachineWidget'
require 'Qt'

class MyDialog < Qt::Dialog
	attr_accessor :main
end

class FullMainWindow < Qt::MainWindow
	attr_accessor :f, :a, :b, :n, :m 
	slots 'up()', 'down()', 'nextMove()', 'previousMove()', 'play()', 'stop()', 'timeout()', 'reset()', 'buildGraph()'
	def insert(n,m,a,b)
		@n , @m , @a , @b = n, m, a, b
		@a[m+n] = 0
		@b[m+n] = 0
		@s = Array.new
		@s[m] = 0
		i = m - 1
		while (i >= 0) do
			@s[i] = (@s[i + 1] >> 1) + ( @a[i] & @b[i] )
			i = i - 1
		end
		@s[m+n] = 0
		@move = 0
		@timer = Qt::Timer.new( self )
		@w = Array.new
		@f = Ui::MainWindow.new
		@f.setupUi( self )
		@scrollArea = Qt::ScrollArea.new(@f.frame)
		@scrollArea.setGeometry( 5 , 5 , 426 , 566 )
		bl = Qt::VBoxLayout.new( @scrollArea )
		@dop = (@n > 6)?6:@n
		@smesh = 0
		for i in (1..@dop)
			@w[i] = FullMachineWidget.new
			bl.addWidget @w[i] 
		end
	end

	def initialize(n,m,a,b,parent = nil)
		super parent
		insert(n,m,a,b)
		proecirovanie
		@f.upButton.setDisabled true 
		@f.downButton.setDisabled true if (@dop >= @n)
		@f.moveCounter.enabled = false
		@f.moveCounter.setText( @move.to_s )
		connect( @f.upButton, SIGNAL('clicked()'), self, SLOT('up()'))
		connect( @f.downButton, SIGNAL('clicked()'), self, SLOT('down()'))
		connect( @f.nextMove, SIGNAL('clicked()'), self, SLOT('nextMove()'))
		connect( @f.previousMove, SIGNAL('clicked()'), self, SLOT('previousMove()'))
		@f.stop.setDisabled true
		connect( @f.play, SIGNAL('clicked()'), self, SLOT('play()'))
		connect( @f.stop, SIGNAL('clicked()'), self, SLOT('stop()'))
		connect( @f.reset, SIGNAL('clicked()'), self, SLOT('reset()'))
		connect( @f.buildGraph, SIGNAL('clicked()'), self, SLOT('buildGraph()'))
		show
	end
	def buildGraph()
		gd = MyDialog.new( self )
#		gd.main = self
		gd.setMinimumSize(600, 600)
		gd.setMaximumSize(600, 600)
		def gd.generate(m)
			a, b = Array.new(), Array.new()
			for i in (0..m)
				a[i] = 32 + rand( 32 )
				b[i] = 32 + rand( 32 )
			end
			return a, b
		end
		def gd.proecirovanie(m,n)
			max_time = m+n-1
			return max_time
		end
		def gd.drawKE(p)
			nN,mM = 100, 100
			@Kynm = Array.new
			alltime = nN * mM
			for n in (1..nN)
				for m in (1..mM)
					t = proecirovanie(m,n)
					@Kynm = t
					p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
					p.drawPoint(10 + alltime/t , @y - 20 - n)
					p.pen = Qt::Pen.new( Qt::Color.new(0,0,255) )
					p.drawPoint(10 + alltime/t/n , @y* 2 - 10 - n)
				end
			end
		end
		def gd.paintEvent(e)
			@x,@y = 300, 300
			p = Qt::Painter.new( self )
			p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
			p.drawLine( 10, 0, 10 , @y*2 )
			p.drawLine( 0, @y - 20, @x*2, @y-20 )
			p.drawLine( 0, @y*2 - 10, @x*2, @y*2-10 )
			p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
			drawKE(p)
			p.end
		end
		gd.exec
	end
	def reset()
		while @move != 0 do
			previousMove()
		end
	end
	def play()
		return if @move == @m + @n
		speed = @f.speed.text().to_i
		if (speed < 100 || speed > 10000 )
			Qt::MessageBox.warning( self , "Warning", "Values < 100 or > 10000 not normal" )
			return
		end
		@f.play.enabled = false
		@f.stop.enabled = true
		@timer.setInterval( speed )
		connect( @timer, SIGNAL('timeout()'), self, SLOT('timeout()'))
		@timer.start
	end
	def timeout()
		if @move == @m + @n
			stop()
			return 
		end
		nextMove()
	end
	def stop()
		@timer.stop
		@f.play.enabled = true
		@f.stop.enabled = false
	end
	def proecirovanie(some = nil)
		m_dop = @m+@dop
		for i in (1..@dop)
			@w[i].mc.lineEdit_4.setText((i+@smesh).to_s)
		end
		max_time = 0
		for i in (1..@dop)
			start_time = Time.now
			n = @w[i].mc.lineEdit_4.text.to_i - 1
			a = @a[ @m + n ].to_i
			b = @b[ @m + n ].to_i
			c = (a & b).to_i
			s = @s[ @m + n ].to_i
			@w[ i ].mc.lineEdit_a.text = a.to_s(2).rjust(8,"0").scan(/.{4}/).join(" ")
			@w[ i ].mc.lineEdit_b.text = b.to_s(2).rjust(8,"0").scan(/.{4}/).join(" ")
			@w[ i ].mc.lineEdit_c.text = c.to_s(2).rjust(8,"0").scan(/.{4}/).join(" ")
			@w[ i ].mc.lineEdit_s.text = s.to_s(2).rjust(8,"0").scan(/.{4}/).join(" ")
			end_time = Time.now
			max_time = end_time - start_time if (end_time - start_time > max_time)
		end
		max_time		
	end
	def up()
		@f.downButton.setEnabled true 
		@smesh -= 1
		proecirovanie
		@f.upButton.setDisabled true if (@smesh == 0)
	end
	def down()
		@f.upButton.setEnabled true 
		@smesh += 1
		proecirovanie
		@f.downButton.setDisabled true if (@smesh + 6 == @n)
	end
	def nextMove(some = false)
		return nil if @move == @m + @n
		@move += 1
		@a.insert(0,nil)
		@b.insert(0,nil)
		@s.insert(0,nil)
		a= proecirovanie(some)
		@f.moveCounter.setText( @move.to_s ) if !some
		a
	end
	def previousMove()
		return nil if @move == 0
		@move -= 1
		@a.delete_at(0)
		@b.delete_at(0)
		@s.delete_at(0)
		a= proecirovanie
		@f.moveCounter.setText( @move.to_s )
	end
end
