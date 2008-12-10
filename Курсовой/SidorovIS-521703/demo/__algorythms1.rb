=begin
	EXAMPLE of algorythms file
=end
=begin
	Algorythms that user can fluently changing
=end
=begin
	History of players roles
		Each player (class GUIPlayer sdd GUIPlayer.rb) 
			have:
				info : (class Player see Player.rb)
				xx, yy : current place
				mode : ( now it's only :Go )
				ball_mode : (true, false) does player have ball
			can:
				attack(player) : attack player object of class GUIPlayer
				getBallIfPossible : (if ball is under player)
				go2Zone : go to point zone by shortiest way
				go4(player) : go for player object of class GUIPlayer
				go(x, y) : go in x, y direction if it is possible
				fingers : find closiest players (object of GUIPlayer)
				makePass (player) : make pass to player object of class Player
		Each player info (class Player see Player.rb) 
			have:
				name : player name
				speed : speed that used to run for other players
				command : command (Command class see Player.rb) that player belong to
				go4 : object of Player (class Player see Player.rb)
				go4name : string of player name
				attack_strategy : type of attack strategy (given in settings like :AttacTactic) [:Protect, :Wind]
				protect_strategy :  type of protect strategy (given in settings like :ProtectTactic) [:Go4, :Blic, :ProtectZone]
				type : 
					given in function place_command (see below)
					| to Attack Team
						[ :Center, :OffensiveGuard, :TailBack, :KvoterBack, :FullBack, :Receiver, :TimeEnd ]
					| to Protect Team
						[ :DefenseEnd, :DefenseTakle, :LineBacker, :KornerBack, :FreeSafeti, :StrongSafeti ]
		Each command (Command class have see Player.rb) 
			have:
				enemy : enemy command (Command class)
				mode : command mode [ :Attacker, :Protector ]
				color : command player color
				players : array of players (class Player see Player.rb)
			can:
				findByName( str ) : find player by name if it is possible
				findByType( type class Player see Player.rb ) : find array of players whis his type if it is possible
		Each ball (class GUIBall see GUIBall.rb) 
			have:
				mode : [ :Player , :Fly , :Ground ]
				player : [ nil , player object (class GUIPlayer see GUIPlayer.rb) ]
				xx, yy : current place (if not with player)
		Each field (class GUIField see GUIField.rb) 
			have:
				players : array of GUIPlayers (class GUIPlayer see GUIPlayer.rb)
				err : error if some option in setting files not correct
				match_end_label : true if match was ended
			can:
				match_end( str_why_reason )
				findByInfo( info ) info class Player (see Player.rb)
				addPlayer( info, x, y, type) create object of class Player (see Player.rb)
		Each game have:
			$field (class GUIField see in GUIField.rb).
			$field.players (array of class GUIPlayer see in GUIPlayer.rb).
			$ball (class GUIBall see in GUIBall.rb).
=end

=begin
function place_command
	input: command, yards
		command (class Command see Player.rb)
		yards <int value>
	ouput: nil
	predestination
		choose players to match.
		place players on the field
=end
def place_command( command, yards )
	c = command
 # deleting all slowest players
	while c.players.size > 11 do
		c.players.delete c.players.first
	end
 # if command mode attackers
	if command.mode == :Attacker
		
		$field.addPlayer( c.players[0] , $field_size_k*yards -10, 0, :Center )
		$field.players.last.init_ball()
		$field.addPlayer( c.players[1] , $field_size_k*yards -10,-$field_size_k*2.7, :OffensiveGuard )
		$field.addPlayer( c.players[2] , $field_size_k*yards -10, $field_size_k*2.7, :OffensiveGuard )
		$field.addPlayer( c.players[3] , $field_size_k*yards -10,-$field_size_k*6.7, :OffensiveTakle )
		$field.addPlayer( c.players[4] , $field_size_k*yards -10, $field_size_k*6.7, :OffensiveTakle )
		$field.addPlayer( c.players[5] , $field_size_k*yards -10 -$field_size_k*12 ,  0, :TailBack )
		$field.addPlayer( c.players[6] , $field_size_k*yards -10 -$field_size_k*8 ,  0, :KvoterBack )
		$field.addPlayer( c.players[7] , $field_size_k*yards -10 -$field_size_k*5,  0, :FullBack )
		$field.addPlayer( c.players[8] , $field_size_k*yards -10 -$field_size_k*1,-$field_size_k*18, :Receiver )
		$field.addPlayer( c.players[9] , $field_size_k*yards -10 -$field_size_k*1, $field_size_k*18, :Receiver )
		$field.addPlayer( c.players[10], $field_size_k*yards -10 -$field_size_k*3, -$field_size_k*8, :TimeEnd )
	else
		$field.addPlayer( c.players[0] , $field_size_k*yards +10, $field_size_k*2.1, :DefenseEnd )
		$field.addPlayer( c.players[1] , $field_size_k*yards +10, -$field_size_k*2.1, :DefenseEnd )
		$field.addPlayer( c.players[2] , $field_size_k*yards +10, $field_size_k*5.5, :DefenseTakle )
		$field.addPlayer( c.players[3] , $field_size_k*yards +10, -$field_size_k*5.5, :DefenseTakle )
		$field.addPlayer( c.players[4] , $field_size_k*yards +10 + $field_size_k*2.5, $field_size_k*4.2, :LineBacker )
		$field.addPlayer( c.players[5] , $field_size_k*yards +10 + $field_size_k*2.5, 0, :LineBacker )
		$field.addPlayer( c.players[6] , $field_size_k*yards +10 + $field_size_k*2.5, -$field_size_k*4.2, :LineBacker )
		$field.addPlayer( c.players[9] , $field_size_k*yards +10 , -$field_size_k*18, :KornerBack )
		$field.addPlayer( c.players[10] , $field_size_k*yards +10 , $field_size_k*18, :KornerBack )
		$field.addPlayer( c.players[7] , $field_size_k*(yards+14) +10 , -$field_size_k*8, :FreeSafeti )
		$field.addPlayer( c.players[8] , $field_size_k*(yards+9) +10 , $field_size_k*8 , :StrongSafeti )
	end
end
=begin
	function that decide what action everyone should do
	input: player (class GUIPlayer see GUIPlayer.rb)
	output: nil
	predestination:
		reseacher can input different algorythms to research system modes
		now there are some situatuions that can be considered at the field (stadnart count of instructions to players)
=end
def what_to_do( player )
 # attacker command mode (1 == korner back don't get ball)
	$a_mode = 1 unless $a_mode		

 # if it possible than get ball ( while ball if flying (making pass to player)
 	getBallIfPossible if @mode == :waitPass

 # if player get ball 
 #    get to point zone
 #             	than it's tachdaun
	if player.ball_mode && player.xx > 45 * $field_size_k
		$field.match_end(" Тачдаун! ")
	end
 # if player have ball
 #    player role = center
 #             	make pass to kvoterback
  	if player.ball_mode && player.info.type == :Center
		pass_to_player_infos = player.info.command.findByType( :KvoterBack )
		player.makePass( $field.findByInfo( pass_to_player_infos[0] ) )
	end
 # if player have ball 
 #    player role is kvoterback
 # 				find players from command with role of receiver and role of kvoterback
 # 				and gave pass to someone of them ( randomly )

   	if player.ball_mode && player.info.type == :KvoterBack
		$a_mode = 2
		pass_to_player_infos = player.info.command.findByType( :Receiver )
		pass_to_player_infos += player.info.command.findByType( :TimeEnd )
		index = rand(3)
		player.makePass( $field.findByInfo( pass_to_player_infos[ index ] ) )
	end
 # if player role receiver
 #    not a time to get pass
 # 				run to center (to avoid korner backs)

	if ((player.info.type == :Receiver) && $a_mode < 2 )
		go(0,0)
	end
 # if player role timeend
 #    not a time to get pass
 # 				run to field end to avoid line backers
	if ((player.info.type == :TimeEnd) && $a_mode < 2 )
		go( player.xx , -$field_size_k * 25  )
	end
 # find all players that are between player
 	a = player.fingers
 # if ball is with some player
 #    player with ball not current player
 #    attack_mode more that 1 (korner back gave pass)
 #    player type == receiver
 # 				if player have better position than @ball.player should gave pass to player
 	if ( $ball.mode == :Player && $ball.player != player && $a_mode > 1 && player.info.type == :Receiver )
		a1 = 0
		a.each { |pl| a1 += 1 if lengthOfVector( pl.xx - player.xx , pl.yy - player.yy ) < $player_size*3 }
		b = $ball.player.fingers
		b1 = 0
		b.each { |pl| b1 += 1 if lengthOfVector( pl.xx - $ball.player.xx , pl.yy - $ball.player.yy ) < $player_size*3  }
		$ball.player.makePass( player ) if b1 > a1
	end
 # if ball is with some player
 # 	  player command type == protectors
 #    is someone near the player
 #  			attack all player with ball if them in attack zone 
	if ( $ball.mode == :Player && player.info.command.mode == :Protector && a.size != 0 )
		a.each { |o_player| player.attack( o_player ) if o_player.ball_mode && lengthOfVector( o_player.xx - player.xx, o_player.yy - player.yy ) < $player_size + 4 }
	end
 # if ball is with some player
 # 	  player command type == protectors
 # 				go forward player if distance to him bigger than some const go to them otherway
	if  ( $ball.mode == :Player && player.info.command.mode == :Protector )
		if ( $ball.player.xx > player.xx && lengthOfVector( player.xx-$ball.player.xx , player.yy - $ball.player.yy ) > $player_size * 2)
			go( $ball.player.xx + $field_size_k*10 , $ball.player.yy )
		else
			go4($ball.player)
	    end
	end
 # if player role receiver
 #    attack_mode more that 1 (korner back gave pass) 
 #    player type == receiver 
 #    and we don't have ball
 # 				wait while player go forwardto me
 	if  (player.info.type == :Receiver && $a_mode > 1  && $ball.mode == :Player && $ball.player != player )
		if ($ball.player.xx < player.xx)
			go(player.xx,player.yy)
		end
	end
 # all the rest should go to there are zone
	player.go2Zone

end
