=begin
	class Player
		include all player info (within GUI and Ball info).
=end
class Player
	attr_reader :name, :speed
	attr_reader :command
	attr_accessor :go4, :go4name, :attack_strategy, :protect_strategy, :type
=begin
	constructor function
		input:
			name  player name
			setting_array  array of possible player settings
			command  which command player are belong to
=end
	def initialize( name, setting_array, command )
		@type = :Null
		@name = name
		@speed = setting_array[ :Speed ]
		@command = command
		init_attack_strategy( setting_array ) 
		init_protect_strategy( setting_array ) 
	end
=begin
	function init_attack_strategy
		setting_array: array of settings
			set attack strategy to player
=end
	def init_attack_strategy( setting_array )
		@attack_strategy = :Wind
		@attack_strategy = setting_array[ :AttackTactic ] if setting_array.has_key? :AttackTactic 
	end
=begin
	function init_protect_strategy
		setting_array: array of settings
			set protect strategy to player
=end
	def init_protect_strategy( setting_array ) 
		@protect_strategy = :Blic
		@protect_strategy = setting_array[ :ProtectTactic ] if setting_array.has_key? :ProtectTactic
		@go4name = setting_array[ :Go4 ] if @protect_strategy == :Go4
		@protect_zone = setting_array[ :ProtectZone ] if @protect_strategy == :ProtectZone
	end
=begin
	function put
		output player info on the screen in beautiful format
=end
	def put()
		puts "  # Игрок: #{@name},  ск: #{@speed}, AS: #{@attack_strategy}, PS: #{@protect_strategy} )".to_left()
	end
=begin
	functions <=> ==
		input:
			other class Player
			decide equalitation betwee Players
=end
	def <=>(other)
		@speed<=>other.speed
	end
	def ==(other)
		return @name == other.name if other.class == Player
		return @name == other if other.class == String
	end
end
=begin
	class Command
		include all command information
=end
class Command
	attr_accessor :enemy, :mode
	attr_accessor :color
	attr_reader :players
=begin 
	constructor function
		input:
			command_name: name of command
			command_hash: command settings(players, command type)
=end
	def initialize( command_name, command_hash )
		@mode = command_hash[:Type]
		@name = command_name
		@players = []
		command_hash[:Players].each { |k,v| @players.push(Player.new(k,v, self)) }
		@players.sort!
	end
=begin
	function put
		output coomand info on the screen in beautiful format
=end
	def put
		puts ("Команда: -= "+@name+" =-").to_right()
		@players.each {|player| player.put }
	end
=begin
	function findByName
		input:
			player_name  String
				find player info (Player.class) by his name
=end
	def findByName( player_name )
		@players.each { |i| return i if i.name == player_name }
		nil
	end
=begin
	function findByType
		input:
			player type (role in tha game)
=end
	def findByType( type )
		ans = []
		@players.each { |i| ans.push(i) if i.type == type }
		ans
	end
=begin
	 function makego4
		find players which should some of player go to
=end
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