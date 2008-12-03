#!/usr/bin/ruby
require 'Qt'
require 'settings_interface.rb'
require 'Player'
require 'ui'
require 'Algorythms'


puts "+"+"-"*$center_value+"+"

if ARGV.size == 0
	puts " Используйте с параметром имени файла настроек".to_center()
else
	begin
		File.new(ARGV[0]+".rb")
		require ARGV[0]
	rescue Errno::ENOENT
		puts "Файла настроек не существует".to_center()
	end
end
if testSettings
	puts " -= Настройки введены верно =- ".to_center()
	command_array = []
	$settings.commands.each {|command_name, command_info| command_array.push([command_name, command_info]) }
	$a = Command.new( command_array[0][0] , command_array[0][1] )
	$b = Command.new( command_array[1][0] , command_array[1][1] )
	$a.enemy, $b.enemy = $b, $a
	$a.color, $b.color = Qt::Color.new(255,0,0), Qt::Color.new(0,0,255)
	$a.makego4;$b.makego4
	$a.put
	$b.put
	app = Qt::Application.new(ARGV)
	ui = UI.new()
	unless ui.err
		app.exec
	end
else
end
puts "+"+"-"*$center_value+"+"