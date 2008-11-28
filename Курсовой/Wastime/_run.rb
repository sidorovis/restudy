#!/usr/bin/ruby
require 'Qt'
require 'settings_interface.rb'
require 'Player'
require 'ui'

$center_value = 70
class String
	def to_center()
		"|"+self.center( $center_value )+"|"
	end
	def to_left()
		"|"+(" "+self).ljust( $center_value )+"|"
	end
	def to_right()
		"|"+(self+" ").rjust( $center_value )+"|"
	end
end
puts "+"+"-"*$center_value+"+"
if ARGV.size == 0
	puts " �ᯮ���� � ��ࠬ��஬ ����� 䠩�� ����஥�".to_center()
else
	begin
		File.new(ARGV[0]+".rb")
		require ARGV[0]
	rescue Errno::ENOENT
		puts "����� ����஥� �� �������".to_center()
	end
end
if testSettings
	puts " -= ����ன�� ������� ��୮ =- ".to_center()
	command_array = []
	$settings.commands.each {|command_name, command_info| command_array.push([command_name, command_info]) }
	$a = Command.new( command_array[0][0] , command_array[0][1] )
	$b = Command.new( command_array[1][0] , command_array[1][1] )
	$a.enemy = $b
	$b.enemy = $a
	$a.color = Qt::Color.new(255,0,0)
	$b.color = Qt::Color.new(0,0,255)
	$a.makego4
	$b.makego4
	$a.put
	$b.put
	app = Qt::Application.new(ARGV)
	ui = UI.new()
	app.exec
else
end
puts "+"+"-"*$center_value+"+"
