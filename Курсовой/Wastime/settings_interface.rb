def testSettings()
	$settings = Settings.new()
# ��।������ ������権 �� ��������� ��⠢
	(puts "������ ஢�� ��� ��������.".to_left();return false;) if $settings.commands.size != 2
	$settings.commands.each { |command_name,command| (puts ("�������� "+command_name+" ������ ᮤ�ঠ�� ������ 11 ��ப��").to_left();return false;) if !command[:Players] || !command[:Players].class == Array || command[:Players].size < 11 }
	true
end

class Settings
	attr_accessor :commands
	def initialize()
		Init()
	end
end