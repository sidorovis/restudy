require 'Lab3'

class GraphWindow

	slots 'CreateConvex()', 'SimpleFill()', 'StackFill()', 'MixFill()',
			'justDrawConvex()'

	alias :old4_connectActions :connectActions
private
	def find_lowest( m )
		y_min = m[0][1]
		di = 0;
		for i in 0..m.size-1 do
#puts " $ #{y_min} #{m[0][1]}  "
			di,y_min = i,m[i][1] if m[i][1] < y_min
		end
		di
	end
	def find_next(m,ci,dots,f)
		x0, y0 = m[ci][0], m[ci][1]
		if dots.size == 1
			m.delete_at(ci)
			n = m.sort { |d1,d2| Math::atan2( d2[1]-y0, d2[0]-x0 ) <=> Math::atan2( d1[1]-y0, d1[0]-x0 )}
			m.insert(ci,[x0,y0])
			return m.index( n[0] )
		end
		
		ds = dots.size
		a = Math::atan2( dots[ds-1][1] - dots[ds-2][1] , dots[ds-1][0] - dots[ds-2][0] )

#puts " block angle #{a}"

		mcopy = Array.new

		m.delete_at(ci)
		m.each { |i| mcopy.push(i) if ((Math::atan2( i[1] - y0 , i[0] - x0 ) <= a) && !(i[1] == y0 && i[0] == x0) ) }
		m.insert(ci,[x0,y0])
		
		n = mcopy.sort { |d1,d2| Math::atan2( d2[1]-y0, d2[0]-x0 ) <=> Math::atan2( d1[1]-y0, d1[0]-x0 )}

#n.each { |i| puts " sorted  \t#{i[0]}\t\t#{i[1]} " }
		
		mcopy.insert(ci,[x0,y0])
		return m.index(f) if n.empty?
#puts " #{n.size}"
#puts " #{n[0][0]}   #{n[0][1]} "
		return m.index( n[0] )
	end
public	
	def justDrawConvex(m)

	m.each { |i| puts " read #{i[0]} #{i[1]}" }
		return nil if m.size == 0
		if m.size == 1
			DrawDot(m[0][0],m[0][1])
			return
		end

		dots = Array.new
		i = find_lowest( m )
		f = m[i].clone
		dots.push( [ m[i][0] , m[i][1] ] )
#puts " FIRST #{m[i][0]} #{m[i][1]}"

		i = find_next(m,i,dots,f)
		while ( m[i][0] != f[0] || m[i][1] != f[1] )
#puts " NOW #{m[i][0]} #{m[i][1]}"
#			getc
			dots.push( [ m[i][0] , m[i][1] ] )
			i = find_next(m,i,dots,f)
		end

		st = dots.size
		dots[st] = [dots[0][0],dots[0][1]]
		for i in 0..dots.size-2
			m = Array.new
			m[0] = [ dots[i][0]   , dots[i][1]   ]
			m[1] = [ dots[i+1][0] , dots[i+1][1] ]
			justDrawADCLine(m)
		end
	end


	def CreateConvex
		StartWorkAction :DrawConvex
	end
	

	def connectActions
		old4_connectActions

		@commands[:DrawConvex] = 	[
			:saveWhileMouse,
			:justDrawConvex
									];
=begin		
		@commands[:DrawErmitSpline] = 	[
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:justDrawSpline
								];
		@commands[:DrawBSpline] = 	[
			:saveWhileMouse,
			:justDrawBSpline
								];
=end

		connect( @f.actionCreateConvex, SIGNAL('triggered()') , self , SLOT('CreateConvex()') )
		connect( @f.actionSimpleFill , SIGNAL('triggered()') , self , SLOT('SimpleFill()') )
		connect( @f.actionStackFill , SIGNAL('triggered()') , self , SLOT('StackFill()') )
		connect( @f.actionMixFill , SIGNAL('triggered()') , self , SLOT('MixFill()') )
		
	end
end