=begin
	player tactics:
		attack:
			:Wind
			:Protect
		protects:
			:Blic
			:Go4
			:ProtectZone
=end

class Player
	attr_reader :name, :speed
	attr_reader :command
	attr_accessor :go4, :go4name, :attack_strategy, :protect_strategy, :type
	def initialize( name, setting_array, command )
		@type = :Null
		@name = name
		@speed = setting_array[ :Speed ]
		@command = command
		init_attack_strategy( setting_array ) 
		init_protect_strategy( setting_array ) 
	end
	def init_attack_strategy( setting_array )
		@attack_strategy = :Wind
		@attack_strategy = setting_array[ :AttackTactic ] if setting_array.has_key? :AttackTactic 
	end
	def init_protect_strategy( setting_array ) 
		@protect_strategy = :Blic
		@protect_strategy = setting_array[ :ProtectTactic ] if setting_array.has_key? :ProtectTactic
		@go4name = setting_array[ :Go4 ] if @protect_strategy == :Go4
		@protect_zone = setting_array[ :ProtectZone ] if @protect_strategy == :ProtectZone
	end
	def put()
		puts "  # Игрок: #{@name},  ск: #{@speed}, AS: #{@attack_strategy}, PS: #{@protect_strategy} )".to_left()
	end
	def <=>(other)
		@speed<=>other.speed
	end
	def ==(other)
		return @name == other.name if other.class == Player
		return @name == other if other.class == String
	end
end
class Command
	attr_accessor :enemy, :mode
	attr_accessor :color
	attr_reader :players
	def initialize( command_name, command_hash )
		@mode = command_hash[:Type]
		@name = command_name
		@players = []
		command_hash[:Players].each { |k,v| @players.push(Player.new(k,v, self)) }
		@players.sort!
	end
	def put
		puts ("Команда: -= "+@name+" =-").to_right()
		@players.each {|player| player.put }
	end
	def findByName( player_name )
		@players.each { |i| return i if i.name == player_name }
		nil
	end
	def findByType( type )
		ans = []
		@players.each { |i| ans.push(i) if i.type == type }
		ans
	end
	def makego4
		for player in @players
			if player.protect_strategy == :Go4
				player.go4 = @enemy.findByName( player.go4name )
#				(player.protect_strategy = :Blic ;puts "!! Игроку #{player.name} тактика защиты сменена на :Blic ".to_left()) unless player.go4
				player.protect_strategy = :Blic unless player.go4
				player.go4name = nil
			end
		end
	end
end