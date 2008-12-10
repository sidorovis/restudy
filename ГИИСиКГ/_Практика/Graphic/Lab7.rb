require 'Lab6'

class GraphWindow

	slots 'Deleting()', 'NotDeleting()'

	alias :old7_connectActions :connectActions
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
	def delete_unvisible( m )
		m
	end	

	def Deleting
		return unless @paint_mode == :Proection
		@deleting_mode = true
		
	end
	def NotDeleting
		return unless @paint_mode == :Proection
		@deleting_mode = false

	end

	def connectActions()
		old7_connectActions
		@deleting_mode = true
		
		connect( @f.actionDeleting, SIGNAL('triggered()') , self , SLOT('Deleting()') )
		connect( @f.actionNotDeleting , SIGNAL('triggered()') , self , SLOT('NotDeleting()') )
				
	end

end