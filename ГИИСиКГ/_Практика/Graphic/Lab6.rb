require 'Lab5'

class GraphWindow

	slots 'FrameMode()', 'NoFrameMode()'

	alias :old6_connectActions :connectActions
	alias :old2_addedKeyReleaseEvent :addedKeyReleaseEvent
	alias :old_justDrawDot :justDrawDot
	alias :old2_DrawDot :DrawDot
	alias :old2_DrawAlgorythm :DrawAlgorythm

	class Frame
		attr_accessor :cx, :cy, :r, :lc, :a
		def initialize()
			@cx, @cy, @r, @lc, @a = 0, 0, 40, 4, Math::PI / 2
		end
		def makePolygon()
			m = []
			for i in (0..@lc-1)
				m[i] = [cx + r * Math.sin(@a), cy + r * Math.cos(@a)]
				@a = @a + 2*Math::PI / @lc
			end
			m
		end
	end

	def DrawAlgorythm
		if @fn_mode == :Frame
			m = @@frame.makePolygon
			m[ m.size ] = m[0]
			@pa.brush = Qt::Brush.new( Qt::Color.new(210,210,210) )
			@DrawDotMode = :justDraw
			for i in (1..m.size-1)
				m1 = []
				m1[0] = [ m[i][0].round , m[i][1].round ]
				m1[1] = [ m[i-1][0].round , m[i-1][1].round ]
				justDrawADCLine( m1 )
#				old_justDrawDot(i[0],i[1])
			end
			@DrawDotMode = :Draw
		end
		old2_DrawAlgorythm
	end
	def DrawDot(x,y,z = 0)
		if @DrawDotMode == :Draw
			old2_DrawDot(x,y)
		else
			justDrawDot(x,y)
		end
	end	
	def justDrawDot(x,y,z=0)
#		puts x,y
		@pa.brush = Qt::Brush.new( Qt::Color.new(0,0,0) )
		if @fn_mode == :Frame
			@pa.brush = Qt::Brush.new( Qt::Color.new(120,120,120) )	if x > 0 
		end
		@pa.brush = Qt::Brush.new( Qt::Color.new(210,210,210) ) if @DrawDotMode == :justDraw
		old_justDrawDot(x,y)
	end
	def FrameMode()
		@fn_mode = :Frame
		repaint
	end
	def NoFrameMode()
		@fn_mode = :NoFrame
		repaint
	end

	alias :old2_addedKeyReleaseEvent :addedKeyReleaseEvent
	
	def addedKeyReleaseEvent(e)
		old2_addedKeyReleaseEvent(e)
		
		@@frame.cx -=1 if e.key == 74	# j
		@@frame.cy +=1 if e.key == 73	# i
		@@frame.cy -=1 if e.key == 75	# k
		@@frame.cx +=1 if e.key == 76	# l
		@@frame.r +=1 if e.key == 93	# ]
		@@frame.r -=1 if e.key == 91	# [
		@@frame.lc +=1 if e.key == 39	# '
		@@frame.lc -=1 if e.key == 59	# ;
		@@frame.a +=14 if e.key == 46	# .
		@@frame.a -=14 if e.key == 44	# ,
		puts e.key
	end


	def connectActions()
		old6_connectActions
		@fn_mode = :NoFrame
		@DrawDot = :Draw
		@@frame = Frame.new		
		connect( @f.actionFrameMode, SIGNAL('triggered()') , self , SLOT('FrameMode()') )
		connect( @f.actionNoFrameMode , SIGNAL('triggered()') , self , SLOT('NoFrameMode()') )
		
	end
	
end