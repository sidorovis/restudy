=begin
	EXAMPLE of setting file to game
=end
puts " -< ��ந ����⥫��� ����� -vs- ��ந ���� ����� v. 0.0.2 >- ".to_center()
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
     "���襡�� �㯮����" =>
       {
         :Players =>
         {
             "�����������" => 	{ :Speed => 2 },
             "���� �����" =>	{ :Speed => 5 },
             "��ନ���" => 	{ :Speed => 3 },
             "��� �����" =>	{ :Speed => 10 },
             "��������" => 	{ :Speed => 7 },
             "�����" =>	 	{ :Speed => 3 },
             "������ �����" => 	{ :Speed => 4 },
             "������ �����" =>	{ :Speed => 8 },
             "���� �����" =>	{ :Speed => 2 },
             "�ࠪ� ���䮩" =>	{ :Speed => 4 },
             "���� ���⨣��" =>{ :Speed => 2 },
             "����� ���" =>	{ :Speed => 4 },
             "���� �������" => 	{ :Speed => 6 },
             "���� ����" =>	{ :Speed => 9 },
             "�㡥�� ���ਤ" => { :Speed => 3 },
             "�����������" => 	{ :Speed => 1 }
         },
#	      :Type => :Attacker
	      :Type => :Protector
       },
      "��������� ����" =>
       { :Players =>
         {
            "�����" => 		{ :Speed => 6, :AttackTactic => :Protect , :ProtectTactic => :Go4, :Go4 => "��������" },
            "������" => 	{ :Speed => 4 },
            "�������" => 	{ :Speed => 3 },
            "�த�" => 		{ :Speed => 6, :ProtectTactic => :Go4, :Go4 => "�ࠣ��" },
            "��" => 		{ :Speed => 4 },
            "�������� ����" => { :Speed => 3 },
            "�������� ���" => { :Speed => 2 },
            "���஭" =>		{ :Speed => 1 },
            "���졮 �����" => { :Speed => 6 },
            "����" => 		{ :Speed => 1 },
            "������" =>		{ :Speed => 3 },
            "�ࠣ��" =>	{ :Speed => 5 },
            "��஭�" =>		{ :Speed => 4 },
            "���㬠��" =>	{ :Speed => 2 },
            "��஬��" =>	{ :Speed => 3 },
            "�����" =>		{ :Speed => 5 },
            "��� ��������" =>	{ :Speed => 3 }
     },
     :Type => :Protector
    }
   }
  @place = 10
 end
end