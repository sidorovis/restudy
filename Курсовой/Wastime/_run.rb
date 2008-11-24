#!/usr/bin/ruby
require 'settings_interface.rb'
require 'ui'

$center_value = 150
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
#	ui = UI.new()	
else
end