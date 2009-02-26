#!/opt/local/bin/ruby
require 'level'
require 'adapter'
require 'Qt'
require 'f1'
require 'f2'
require 'f3'
require 'f4'

def start_s()
	loop do
	res = start_level
	if res == -1
		puts "Досвидания"
		exit
	end
	if res < Percents * $quest_per_level
	    $quests = get_quests();
	else
	    $quests = get_quests();
	    $level += 1
	    if $level > Max_level
			d1 = Ui_Form.new()
			d1.setupUi(d11 = Qt::Dialog.new())
			d11.exec
			exit
	    end
		d1 = Ui_F4.new()
		d1.setupUi(d11 = Qt::Dialog.new())
		d11.exec		
	end
    end
end


$quests = get_quests();
Min_level = 1
Max_level = 5

$level = Min_level
$quest_per_level = 3
Percents = 0.6
app = Qt::Application.new(ARGV)
d1 = Ui_F1.new()
d1.setupUi(d11 = Qt::Dialog.new())
if (d11.exec == Qt::Dialog::Accepted)
    start_s()
else
    exit
end
app.exec

