require 'Lab4'
X = 400
Y = 300
$log = false

app = Qt::Application.new(ARGV)
graph_window = GraphWindow.new(X, Y)
app.exec
