def place_command( command, yards )
	c = command
	while c.players.size > 11 do
		c.players.delete c.players.first
	end
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
		$field.addPlayer( c.players[7] , $field_size_k*yards +10 , -$field_size_k*18, :KornerBack )
		$field.addPlayer( c.players[8] , $field_size_k*yards +10 , $field_size_k*18, :KornerBack )
		$field.addPlayer( c.players[9] , $field_size_k*(yards+14) +10 , -$field_size_k*8, :FreeSafeti )
		$field.addPlayer( c.players[10] , $field_size_k*(yards+9) +10 , $field_size_k*8 , :StrongSafeti )
	end
end

 # player is object of GUIPlayer
def what_to_do( player )

	getBallIfPossible if @mode == :waitPass
# здесь нужен switch
	if player.ball_mode && player.info.type == :Center
		pass_to_player_infos = player.info.command.findByType( :KvoterBack )
		player.makePass( $field.findByInfo( pass_to_player_infos[0] ) )
	end
	if player.ball_mode && player.info.type == :KvoterBack
		pass_to_player_infos = player.info.command.findByType( :Receiver )
		index = rand().round
		player.makePass( $field.findByInfo( pass_to_player_infos[ index ] ) )
	end
	if (
		  ( $ball.mode == :Fly || 
		  ( $ball.mode == :Player && $ball.player.info.type != :Receiver )
		  ) && !player.ball_mode && player.info.type == :Receiver
		)
		go(0,0)
	end
	player.go2Zone

	repaint
end
