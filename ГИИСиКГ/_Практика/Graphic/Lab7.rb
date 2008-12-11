require 'Lab6'

class GraphWindow

	slots 'Deleting()', 'NotDeleting()'

	alias :old7_connectActions :connectActions

	def create2d_arr( a )
		p1 = Array2.new
		p1[1,1],p1[1,2],p1[1,3],p1[1,4] = 1.0*a[0], 1.0*a[1], 1.0*a[2], 1.0*a[3]
		p11 = p1*@@e*@@t
		return p11
	end
	def makeABCDv( r )
		p11 = create2d_arr( r[0] )
		p22 = create2d_arr( r[1] )
#		puts p11, p22
		a,b,c = 1.0*(p22[1,1]-p11[1,1]) , 1.0*(p22[1,2]-p11[1,2]), 1.0*(p22[1,3]-p11[1,3])
		d = -a*p11[1,1] - b*p11[1,2] - c*p11[1,3]
		return a,b,c,d
	end
	def makeABCD( r )
		a1,b1,c1,d1 = makeABCDv( @@o[ r[ 0 ] ] )
		a2,b2,c2,d2 = makeABCDv( @@o[ r[ 1 ] ] )
		a , b , c = b1*c2-c1*b2 , c1*a2-a1*c2 , a1*b2-b1*a2
		d = -a*@@o[ r[ 0 ] ][0][0]-b*@@o[ r[ 0 ] ][0][1]-c*@@o[ r[ 0 ] ][0][2]
		return [a,b,c,d]
	end
	def getCenter()
		x = y = z = 0.0
		@@o_d.each { |dot| p1 = create2d_arr( dot ); x+=p1[1,1];y+=p1[1,2];z+=p1[1,3]; }
		x /= @@o_d.size
		y /= @@o_d.size
		z /= @@o_d.size
		return x,y,z
	end
	
	def delete_unvisible( m )
		o = m.clone
		o1 = []
		xc,yc,zc = getCenter()
		for gran in @@o_g
			abcdv = makeABCD( gran )
			puts abcdv.join("\t")
			if ( abcdv[0]*xc+abcdv[1]*yc+abcdv[2]*zc+abcdv[3] < 0)
				abcdv[0] *= -1
				abcdv[1] *= -1
				abcdv[2] *= -1
				abcdv[3] *= -1
			end
			if ( abcdv[0]*0 + abcdv[1]*0 + abcdv[2]*(1) + abcdv[3]*0 > 0 )
				for rebro_index in gran
					o1 << @@o[ rebro_index ]
				end
			end
		end
		o1
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