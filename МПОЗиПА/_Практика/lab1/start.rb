require 'fullGenerateForm'
require 'fullMainWindow'
require 'fullMachineWidget'

app = Qt::Application.new(ARGV)
generateForm = FullGenerateForm.new()
generateForm.exec
f = generateForm.f
m = f.m_Edit.text.to_i
n = f.n_Edit.text.to_i
exit if ( !(0 < m && m < 51) || !(0 < n && n < 51) )

a, b = Array.new(), Array.new()
(0..m-1).each { |i| a[i], b[i] = f.a_b_arrays.item(i,0).text.to_i, f.a_b_arrays.item(i,1).text.to_i }
generateForm.show
mainWindow = FullMainWindow.new(n,m,a,b,f.a_b_arrays)
app.exec
