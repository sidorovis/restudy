=begin
	EXAMPLE of setting file to game
=end
puts " -< Герои Властелина Кольца -vs- Герои Гарри Поттера v. 0.0.2 >- ".to_center()
=begin
 class Settings
  including:
  function Init()
  start place for tournament
=end
class Settings
=begin
 function Init
 initializing command settings
 and start point to tournament
 gramm:
 	@commands = { <First command name> => { <:PlayersDefiner>, <:CommandTypeDefiner> }, <Second command name> => { <:PlayersDefiner>, <:CommandTypeDefiner> } }
 	@place = <int value [ -40, -30, -20, -10 , 0 , 10 , 20, 30 , 40 ]>

 	<First command name> = <String value>
 	<Second command name> = <String value>
 	<:PlayersDefiner> = :Players => { <:Player> ( , <:Player> )* }
 	<:CommandTypeDefiner> = :Type => [ :Attacker, :Protector ]
 	<:Player> = <PlayerName> => { <:PlayerSettings> }
 	<PlayerName> = <String value>
 	<:PlayerSettings> = { :Speed => <int value> (, :AttackTactic => [:Protect, :Wind] )? (, :ProtectTactic => [(:Go4 , :Go4=> <PlayerName> ), :Blic, :ProtectZone ])? }
=end 

 def Init()
  @commands = 
   {
     "Волшебные Тупоносы" =>
       {
         :Players =>
         {
             "Воландеморт" => 	{ :Speed => 2 },
             "Гарри Поттер" =>	{ :Speed => 5 },
             "Гермиона" => 	{ :Speed => 3 },
             "Рон Уизли" =>	{ :Speed => 10 },
             "Дамблдор" => 	{ :Speed => 7 },
             "Снейп" =>	 	{ :Speed => 3 },
             "Джинни Уизли" => 	{ :Speed => 4 },
             "Джеймс Поттер" =>	{ :Speed => 8 },
             "Лили Эванс" =>	{ :Speed => 2 },
             "Драко Малфой" =>	{ :Speed => 4 },
             "Питера Петтигрю" =>{ :Speed => 2 },
             "Сириус Блэк" =>	{ :Speed => 4 },
             "Флёр Делакур" => 	{ :Speed => 6 },
             "Аргус Филч" =>	{ :Speed => 9 },
             "Рубеус Хагрид" => { :Speed => 3 },
             "Макгонагалл" => 	{ :Speed => 1 }
         },
#	      :Type => :Attacker
	      :Type => :Protector
       },
      "Легендарные Дятлы" =>
       { :Players =>
         {
            "Балин" => 		{ :Speed => 6, :AttackTactic => :Protect , :ProtectTactic => :Go4, :Go4 => "Дамблдор" },
            "Двалин" => 	{ :Speed => 4 },
            "Леголаз" => 	{ :Speed => 3 },
            "Фродо" => 		{ :Speed => 6, :ProtectTactic => :Go4, :Go4 => "Арагорн" },
            "Сэм" => 		{ :Speed => 4 },
            "Гендальф белый" => { :Speed => 3 },
            "Гендальф серый" => { :Speed => 2 },
            "Саурон" =>		{ :Speed => 1 },
            "Бильбо Бэггинс" => { :Speed => 6 },
            "Мэрри" => 		{ :Speed => 1 },
            "Пиппин" =>		{ :Speed => 3 },
            "Арагорн" =>	{ :Speed => 5 },
            "Элронд" =>		{ :Speed => 4 },
            "Сарумана" =>	{ :Speed => 2 },
            "Боромир" =>	{ :Speed => 3 },
            "Гимли" =>		{ :Speed => 5 },
            "Том Бомбадил" =>	{ :Speed => 3 }
     },
     :Type => :Protector
    }
   }
  @place = 10
 end
end