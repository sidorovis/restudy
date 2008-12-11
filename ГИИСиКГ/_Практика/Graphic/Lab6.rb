require 'Lab5'

class GraphWindow

	slots 'FrameMode()', 'NoFrameMode()'

	alias :old6_connectActions :connectActions
=begin
	alias :old2_addedKeyReleaseEvent :addedKeyReleaseEvent
	alias :old_justDrawDot :justDrawDot
	alias :old2_DrawDot :DrawDot
	alias :old2_DrawAlgorythm :DrawAlgorythm

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

=end

	def FrameMode()
		return if @paint_mode != :Paint
		@paint_mode = :Frame
		repaint
	end
	def NoFrameMode()
		return if @paint_mode != :Frame
		@paint_mode = :Paint
		repaint
	end

	def connectActions()
		old6_connectActions
		


		connect( @f.actionFrameMode, SIGNAL('triggered()') , self , SLOT('FrameMode()') )
		connect( @f.actionNoFrameMode , SIGNAL('triggered()') , self , SLOT('NoFrameMode()') )
		
	end

end