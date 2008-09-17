require 'main_window.ui'
require 'FullMachineWidget'
require 'FullGenerateForm'
require 'Qt'

class MyDialog < Qt::Dialog
	attr_accessor :main
end

class FullMainWindow < Qt::MainWindow
	attr_accessor :f, :a, :b, :n, :m, :copy_s
	slots 'up()', 'down()', 'nextMove()', 'previousMove()', 'play()', 'stop()', 'timeout()', 'reset()', 'buildGraph()'
	def insert(n,m,a,b)
		@copy_s = Array.new(0)
		@n , @m , @a , @b = n, m, a, b
		@a[m+n] = 0
		@b[m+n] = 0
		@s = Array.new(0)
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

	def initialize(n,m,a,b,a_b,parent = nil)
		super parent
		insert(n,m,a,b)
		proecirovanie
		@a_b = a_b
		@f.upButton.setDisabled true 
		@f.previousMove.setDisabled true 
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
		connect( @timer, SIGNAL('timeout()'), self, SLOT('timeout()'))
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
				a[i] = rand( 2**4 )
				b[i] = rand( 2**4 )
			end
			return a, b
		end
		def gd.proecirovanie(m,n)
			m+n-1
		end
		def gd.drawKE(p)
			nN,mM = 4, 10
			@Kynm = Array.new
			m = 10
			ko = 13
			m_t = 0
			ky = 0
			e = 0
			for rn in (1..nN)
			if (4 % rn == 0)
				for rm in (mM..mM)
					m = rm
					n = rn
					alltime = n * m
					t = proecirovanie(m,n)
					@Kynm = t
					p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
#					p.drawLine(10 + n -5, @y - 20 - (alltime*1.0 / t)*50 -5 , 10 + n + 5 , @y - 20 - (alltime*1.0 / t)*50 + 5);
#					p.drawText(10 + n - 5, @y - 20 - (alltime*1.0 / t)*50  - 5, "n = #{n}" );
					p.drawPoint(10 + n*10 , @y - 20 - (alltime*1.0 / t)*50)
					p.pen = Qt::Pen.new( Qt::Color.new(0,0,255) )
#					p.drawLine(10 + n -5, @y*2 - 10 - (alltime*1.0 / t/n)*(ko**2) -5 , 10 + n + 5 , @y*2 - 10 - (alltime*1.0 / t / n)*(ko**2) + 5);
#					p.drawText(10 + n - 5 , @y*2 - 10 - (alltime*1.0 / t/n)*(ko**2) - 5  , "m = #{n}");
					p.drawPoint(10 + n*10 , @y*2 - 10 - (alltime*1.0/t/n)*(ko**2))
					m_t = m
					ky = (alltime*1.0 / t)
					e = (alltime*1.0/t/n)
#					p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
#					p.drawText(10 + m_t, (@y*2) - 10 - ((e)*(ko**2)), " n = #{rn}") if rm == 1
				end
#				p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
#				p.drawText(10 + m_t, @y - 20 - ky*50, ky.to_s)
#				p.drawText(10 + m_t - 100, @y - 20 - ky*50, rn.to_s)
#				p.drawText(10 + m_t, (@y*2) - 10 - ((e)*(ko**2)) - (2.5 - rn)*10, e.to_s)
			end
			end
		end
		def gd.paintEvent(e)
			@x,@y = 300, 300
			p = Qt::Painter.new( self )
			p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
			p.drawLine( 10, 0, 10 , @y*2 )
			p.drawText( @x*2 - 20 , @y - 25 , "r")
			p.drawText( @x*2 - 20 , @y*2 - 15 , "r")
			p.drawLine( 0, @y - 20, @x*2, @y-20 )
			p.drawLine( 0, @y*2 - 10, @x*2, @y*2-10 )

			(1..55).each { |i| p.drawLine( 10 + i*10, @y - 25 , 10 + i*10, @y - 15 ) }
			(1..55).each { |i| p.drawLine( 10 + i*10, @y*2 - 15 , 10 + i*10, @y*2 - 5 ) }
			(1..30).each { |i| p.drawText( 5+i*20, @y - 25 , "#{i*20}") }
			(1..30).each { |i| p.drawText( 5+i*20, @y*2 - 15 , "#{i*20}") }

			p.drawLine( 0, @y - 20 - 50, 20, @y-20 - 50 )
			p.drawText( 0, @y - 20 - 50, "1" )

			p.drawLine( 0, @y*2 - 10 - 13**2, 10, @y*2 - 10 - 13**2 )
			p.drawText( 0, @y*2 - 10 - 13**2, "1" )
			p.drawText( 0, @y*2 - 10 - 13**2.0/(4.0/3), "0.75" )
			p.drawText( 0, @y*2 - 10 - 13**2/2.0, "0.5" )
			p.drawText( 0, @y*2 - 10 - 13**2/4.0, "0.25" )
			
			p.drawText( 15,15,"Ky")
			p.drawText( 15 ,15+@y,"E")
			p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
			drawKE(p)
			p.end
		end
		gd.exec
	end
	def reset()
		@s.clear
		while @move != 0 do
			previousMove()
		end
		@s.clear
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
		@timer.start
	end
	def timeout()
		if @move == @m + @n
			stop()
		end
		nextMove()
	end
	def stop()
		@timer.stop
		@f.play.enabled = true
		@f.stop.enabled = false
	end
	def proecirovanie(some = nil)
#	  puts @s.join(" ")
		m_dop = @m+@dop
		for i in (1..@dop)
			@w[i].mc.lineEdit_4.setText((i+@smesh).to_s)
		end
		max_time = 0
		for i in (1..@dop)
			start_time = Time.now
			n = @w[i].mc.lineEdit_4.text.to_i - 1
			summa = 0
			summa = @s[ i ] if @s[i]

			st = 2**(@dop - i)

#		print n,"  ", st, "\n" ;
		
			a = @a[ @m + n ].to_i
			b = @b[ @m + n ].to_i
			c = 0
			c = a if (b & st != 0)
			c = c << ( @dop - i )

			s = c + summa

			@w[ i ].mc.lineEdit_a.text = a.to_s(2).rjust(8,"0").scan(/.{4}/).join(" ")
			@w[ i ].mc.lineEdit_b.text = b.to_s(2).rjust(8,"0").scan(/.{4}/).join(" ")
			@w[ i ].mc.lineEdit_c.text = c.to_s(2).rjust(8,"0").scan(/.{4}/).join(" ")
			@w[ i ].mc.lineEdit_s.text = s.to_s(2).rjust(12,"0").scan(/.{4}/).join(" ")
			end_time = Time.now
			max_time = end_time - start_time if (end_time - start_time > max_time)
			@s[i] = s
		end
#		puts "---------------";
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
#		@s = Array.new(0) if @move == @m + @n
		if @move == @m + @n
#puts "1111   ",@s
			form = FullGenerateForm.new(@a_b,@m,@s,@n)
			@timer.stop
			form.exec
			return nil
		end
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
#		a= proecirovanie
		@f.moveCounter.setText( @move.to_s )
	end
end
