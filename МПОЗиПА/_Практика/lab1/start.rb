require 'konveer.rb'

class MyForm < Qt::Widget
	include Ui
	def initialize()
		super()
		f = Form.new
		f.setupUi( self )
		show
	end
end


app = Qt::Application.new(ARGV)
myForm = MyForm.new()
app.exec