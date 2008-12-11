require 'Lab6'

class GraphWindow

	slots 'Deleting()', 'NotDeleting()'

	alias :old7_connectActions :connectActions

	def makeABCDv( r )
		a,b,c = r[0][0] - r[1][0], r[0][1]-r[1][1], r[0][2]-r[1][2]
		d = -a*r[0][0]-b*r[0][1]-c*r[0][2]
		return a,b,c,d
	end
	def makeABCD( r )
		a1,b1,c1,d1 = makeABCDv( @@o[ r[ 0 ] ] )
		a2,b2,c2,d2 = makeABCDv( @@o[ r[ 1 ] ] )
#		v1[1]
		a , b , c = b1*c2-c1*b2 , c1*a2-a1*c2 , a1*b2-b1*a2
		d = -a*@@o[ r[ 0 ] ][0][0]-b*@@o[ r[ 0 ] ][0][1]-c*@@o[ r[ 0 ] ][0][2]
		return [a,b,c,d]
	end
	def getCenter()

	end
	
	def delete_unvisible( m )
		o = m.clone
		abcd = []
		@@o_g.each { |i| abcd << makeABCD( i ) }
		puts "______________________"
		puts abcd.size
		abcd.each { |i| puts i.join(" | ") }
		xc,yc,zc = getCenter()
		o
	end	

	def Deleting
		return if @paint_mode != :Proection
		@deleting_mode = true
		repaint
	end
	def NotDeleting
		return unless @paint_mode == :Proection
		@deleting_mode = false
		repaint
		end

	def connectActions()
		old7_connectActions
		@deleting_mode = false
		
		connect( @f.actionDeleting, SIGNAL('triggered()') , self , SLOT('Deleting()') )
		connect( @f.actionNotDeleting , SIGNAL('triggered()') , self , SLOT('NotDeleting()') )
				
	end

end