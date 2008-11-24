def testSettings()
	$settings = Settings.new()
# определение валидаций на коммандный состав
	(puts "Введите ровно две комманды.".to_left();return false;) if $settings.commands.size != 2
	$settings.commands.each { |command_name,command| (puts ("Комманда "+command_name+" должна содержать минимум 11 игроков").to_left();return false;) if !command[:Players] || !command[:Players].class == Array || command[:Players].size < 11 }
	true
end

class Settings
	attr_accessor :commands
	def initialize()
		Init()
	end
end