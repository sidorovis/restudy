require 'Lab1'

X = 400
Y = 300

app = Qt::Application.new(ARGV)
graph_window = GraphWindow.new(X, Y)
app.exec