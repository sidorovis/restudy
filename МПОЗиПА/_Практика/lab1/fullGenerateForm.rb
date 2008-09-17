require 'generate_form.ui'

class FullGenerateForm < Qt::Dialog
	attr_reader :f
	slots 'generateButtonClicked()', 'okButtonClicked()', 'clicked(QTableWidgetItem *)'
	def generateButtonClicked
		m = @f.m_Edit.text.to_i
		if ( m < 1 || m > 50 )
			mb = Qt::MessageBox.warning( self , "Warning", "Enter integer number between 1 .. 50" )
			return 
		end
		@f.a_b_arrays.row_count = m
		@f.a_b_arrays.column_count = 2
		@f.a_b_arrays.setColumnWidth( 0, 80 )
		@f.a_b_arrays.setColumnWidth( 1, 80 )
		for i in (0..m-1)
			@f.a_b_arrays.setItem( i, 0, Qt::TableWidgetItem.new((rand(2**4)).to_s))
			@f.a_b_arrays.setItem( i, 1, Qt::TableWidgetItem.new((rand(2**4)).to_s))
		end
		@f.a_b_arrays.repaint()
		@f.n_Edit.setFocus( )
		@f.m_Edit.enabled = false
	end
	def okButtonClicked()
		m = @f.m_Edit.text.to_i
		n = @f.n_Edit.text.to_i
		if ( n < 1 || n > 10 ) || ( m < 1 || m > 50 ) || @f.m_Edit.isEnabled
			mb = Qt::MessageBox.warning( self , "Warning", "Enter integer number m between 1 .. 50, n : 1 .. 10 " )
			return
		end
		@f.n_Edit.enabled = false
		@f.m_Edit.enabled = false
#		@f.a_b_arrays.enabled = false
		@f.okButton.enabled = false
		@f.generateButton.enabled = false
		close
	end
	def clicked(i)
		i.setSelected( false )
		@f.okButton.setFocus
	end
	def initialize(a_b = nil,m = nil,s = nil,n = nil)
		super()
		@f = Ui::GenerateForm.new
		@f.setupUi( self )
#		@f.n_Edit.enabled = false
		@f.n_Edit.text = "4"
		if (a_b)
			@m = m
			@f.n_Edit.enabled = false
			@f.m_Edit.enabled = false
			@f.okButton.enabled = false
			@f.generateButton.enabled = false
			(1..5).each { s.delete_at(0) }
			@f.a_b_arrays.column_count = 3
			@f.a_b_arrays.row_count = m
			(0..3).each { |i| @f.a_b_arrays.setItem( i, 2, Qt::TableWidgetItem.new(s[i].to_s) ) }
#			@f.a_b_arrays = a_b
			for i in (0..m-1)
				@f.a_b_arrays.setItem( i, 0, a_b.item(i,0))
				@f.a_b_arrays.setItem( i, 1, a_b.item(i,1))
			end
			setWindowTitle( "S result" )
		end
#		@f.a_b_arrays.enabled = false
		connect( @f.generateButton, SIGNAL('clicked()'), self, SLOT('generateButtonClicked()') )
		connect( @f.okButton, SIGNAL('clicked()'), self, SLOT('okButtonClicked()') )
		connect( @f.a_b_arrays, SIGNAL('itemClicked(QTableWidgetItem *)'), self, SLOT('clicked(QTableWidgetItem *)'))
		connect( @f.a_b_arrays, SIGNAL('itemDoubleClicked(QTableWidgetItem *)'), self, SLOT('clicked(QTableWidgetItem *)'))
		show
	end
end
