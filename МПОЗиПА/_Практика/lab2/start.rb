require 'work'
require 'Qt'

$max_int = 500

$t_umn = 1
$t_sum = 1
$t_min = 1
$t_del = 1
$t_abs = 1
$t_equ = 1

$m = 10
$q = 10

$with_p = 6
$with_n = 6
$with_r = 6

$n_min, $n_max = 1 , 100
$r_min, $r_max = $p_min, $p_max

app = Qt::Application.new(ARGV)
mw = Qt::Dialog.new()
mw.setMinimumSize 600, 600
mw.setMaximumSize 600, 600
#																			Ky(r), E(r)

$p_min, $p_max = 1 , 30
$n = $with_n

$dot_a_ky_r_fix_n = Hash.new
$dot_a_e_r_fix_n = Hash.new
$dot_a_d_r_fix_n = Hash.new
for p in $p_min..$p_max
	$p = p
	a , b = ArrayGenerator()
	c1, time1, timeN, rang, lsredn, lsum = a.my_op(b)
	$r = rang / 800
	$dot_a_ky_r_fix_n[$r] = time1*1.0 / timeN
	$dot_a_e_r_fix_n[$r] = time1*1.0 / timeN / $n
	$dot_a_d_r_fix_n[$r] = rang*1.0 * (lsum / lsredn)
#	puts $r
	puts " n = #{$n}, r = #{$r} \n time1 = #{time1} , timeN = #{timeN} , rang = #{rang}, lsredn = #{lsredn}, lsum = #{lsum}" 
end

def mw.paintEvent(e)
	x = 20
	y = 40
	p = Qt::Painter.new( self )
										# X, Y, lines drawing
	x_c, y_c = 10, 590
	p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
	p.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
	for i in 1..550
		p.drawLine(x_c + i*x, y_c - 5000, x_c + i*x, y_c + 5000)
		p.drawLine(x_c - 5000, y_c - i*y, x_c + 5000, y_c -i*y )
	end
	p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
	p.drawLine(x_c, 600, x_c, 0)
	p.drawLine(0, y_c, 600, y_c)
	p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
	$dot_a_ky_r_fix_n.each { |i,u| p.drawEllipse(x_c + i*x - 1, y_c - (u)*y - 1 , 1 , 1) }
	p.end	
end
mw.setWindowTitle("Ky(r) n = #{$n}")
mw.exec
def mw.paintEvent(e)
	x = 10
	y = 250
	p = Qt::Painter.new( self )
										# X, Y, lines drawing
	x_c, y_c = 10, 590
	p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
	p.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
	for i in 1..550
		p.drawLine(x_c + i*x, y_c - 5000, x_c + i*x, y_c + 5000)
		p.drawLine(x_c - 5000, y_c - i*y, x_c + 5000, y_c -i*y )
	end
	p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
	p.drawLine(x_c, 600, x_c, 0)
	p.drawLine(0, y_c, 600, y_c)
	p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
	$dot_a_e_r_fix_n.each { |i,u| p.drawEllipse(x_c + i*x - 1, y_c - (u)*y - 1 , 1 , 1) }
	p.end	
end
mw.setWindowTitle("E(r) n = #{$n}")
mw.exec
def mw.paintEvent(e)
	x = 10
	y = 0.5
	p = Qt::Painter.new( self )
										# X, Y, lines drawing
	x_c, y_c = 10, 590
	p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
	p.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
	for i in 1..550
		p.drawLine(x_c + i*x, y_c - 5000, x_c + i*x, y_c + 5000)
		p.drawLine(x_c - 5000, y_c - i*y * 10, x_c + 5000, y_c -i*y * 10 )
	end
	p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
	p.drawLine(x_c, 600, x_c, 0)
	p.drawLine(0, y_c, 600, y_c)
	p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
	$dot_a_d_r_fix_n.each { |i,u| p.drawEllipse(x_c + i*x - 1, y_c - (u)*y - 1 , 1 , 1) }
	p.end	
end
mw.setWindowTitle("D(r) n = #{$n}")
mw.exec


#																			Ky(n), E(n)
$r = $with_r
$p = $with_p
$dot_a_ky_n_fix_r = Hash.new
$dot_a_e_n_fix_r = Hash.new
$dot_a_d_n_fix_r = Hash.new

for n in $n_min..$n_max
	$n = n
	a , b = ArrayGenerator()
	c1, time1, timeN, rang, lsredn, lsum = a.my_op(b)
	$dot_a_ky_n_fix_r[$n] = time1*1.0 / timeN
	$dot_a_e_n_fix_r[$n] = time1*1.0 / timeN / $n
	$dot_a_d_n_fix_r[$n] = rang*1.0 * (lsum / lsredn)
#	puts $r
	puts " n = #{$n}, r = #{$r} \n time1 = #{time1} , timeN = #{timeN}, rang = #{rang} lsredn = #{lsredn} lsum = #{lsum}" 
end

def mw.paintEvent(e)
	x = 5
	y = 20
	p = Qt::Painter.new( self )
										# X, Y, lines drawing
	x_c, y_c = 10, 590
	p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
	p.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
	for i in 1..150
		p.drawLine(x_c + i*x, y_c - 5000, x_c + i*x, y_c + 5000)
		p.drawLine(x_c - 5000, y_c - i*y, x_c + 5000, y_c -i*y )
	end
	p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
	p.drawLine(x_c, 600, x_c, 0)
	p.drawLine(0, y_c, 600, y_c)
	p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
	$dot_a_ky_n_fix_r.each { |i,u| p.drawEllipse(x_c + i*x - 1, y_c - (u)*y - 1 , 1 , 1) }
	p.end	
end
mw.setWindowTitle("Ky(n) r = #{$r}")
mw.exec
def mw.paintEvent(e)
	x = 5
	y = 500
	p = Qt::Painter.new( self )
										# X, Y, lines drawing
	x_c, y_c = 10, 590
	p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
	p.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
	for i in 1..150
		p.drawLine(x_c + i*x, y_c - 5000, x_c + i*x, y_c + 5000)
		p.drawLine(x_c - 5000, y_c - i*y, x_c + 5000, y_c -i*y )
	end
	p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
	p.drawLine(x_c, 600, x_c, 0)
	p.drawLine(0, y_c, 600, y_c)
	p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
	$dot_a_e_n_fix_r.each { |i,u| p.drawEllipse(x_c + i*x - 1, y_c - (u)*y - 1 , 1 , 1) }
	p.end	
end
mw.setWindowTitle("E(n) r = #{$r}")
mw.exec
def mw.paintEvent(e)
	x = 5
	y = 0.4
	p = Qt::Painter.new( self )
										# X, Y, lines drawing
	x_c, y_c = 10, 590
	p.fillRect( -1 , -1 , 600 + 1 , 600 + 1, Qt::Brush::new( Qt::Color::new(255,255,255) ))	#	fill white board background
	p.pen = Qt::Pen.new( Qt::Color.new(155,155,255) )
	for i in 1..550
		p.drawLine(x_c + i*x, y_c - 5000, x_c + i*x, y_c + 5000)
		p.drawLine(x_c - 5000, y_c - i*y * 10, x_c + 5000, y_c -i*y * 10 )
	end
	p.pen = Qt::Pen.new( Qt::Color.new(255,0,0) )
	p.drawLine(x_c, 600, x_c, 0)
	p.drawLine(0, y_c, 600, y_c)
	p.pen = Qt::Pen.new( Qt::Color.new(0,0,0) )
	$dot_a_d_n_fix_r.each { |i,u| p.drawEllipse(x_c + i*x - 1, y_c - (u)*y - 1 , 1 , 1) }
	p.end	
end
mw.setWindowTitle("D(n) r = #{$r}")
mw.exec
