require 'Lab7'
X = 400
Y = 300

$log = false
=begin
	app = Qt::Application.new( ARGV )
	a = GraphWindow.new(15,15)
	a1,b1,c1 = a.makeLineParams(0,0,15,0)
	a2,b2,c2 = a.makeLineParams(0,14,15,0)
	puts a.makeLineParams(0,0,0,15).join(", ")
	puts a.makeLineParams(0,14,0,0).join(", ")
	puts a.crossDotByParams(a1,b1,c1,a2,b2,c2).join(" | ")
	return
=end
app = Qt::Application.new( ARGV )
graph_window = GraphWindow.new(X, Y)
app.exec
