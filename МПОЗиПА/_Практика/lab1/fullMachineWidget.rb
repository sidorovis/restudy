require 'machine_widget.ui'

class FullMachineWidget < Qt::Widget
	attr_accessor :lineEdit_4, :lineEdit_a, :lineEdit_3, :lineEdit_2, :mc
	def initialize()
		super
		@mc = Ui::MachineWidget.new
		@mc.setupUi( self )
		show
	end
end