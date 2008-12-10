# window size in konsole
$center_value = 70

# koefficient to field
$field_size_k = 9

# field size relation 
    $x_field_size = 110
    $y_field_size = 49
# additional x, y sizez to field imaging
$additional_xy_size = 5

# speed on witch game started
$start_speed = 6
# maximum game speed
$max_speed = 20
# minimum game speed
$min_speed = 1

# maximum time between steps
$max_time_period = 1000.0

# player circle size
$player_size = 16.0
# ball circle size
$ball_size = 8.0
# ball speed
$ball_speed = 16

=begin
	function testSettings()
		read user settings with information about players names, speed, tactics, etc.
=end
def testSettings()
	$settings = Settings.new()
# определение валидаций на коммандный состав
	(puts "Введите ровно две комманды.".to_left();return false;) if $settings.commands.size != 2
	$settings.commands.each { |command_name,command| (puts ("Комманда "+command_name+" должна содержать минимум 11 игроков").to_left();return false;) if !command[:Players] || !command[:Players].class == Array || command[:Players].size < 11 }

	true
end

=begin
	parent class of Settings
=end
class Settings
	attr_accessor :commands, :place
=begin
	constructor function
		initialize settings
=end
	def initialize()
		Init()
	end
end

############################################################################
# additional global algorythms
class String
public
=begin
	function trans
			put string using english letters
=end
	def trans()
		r = "";
		self.each_byte { |i| r+=String.translate_char( i ) }
		r
	end
private
=begin
	function translate_char (char)
		input char : russian encoding (DOS)
		output char : english (translit) encoding
=end
	def self.translate_char( char )
		r = 'a' if char == 'а'[0]
		r = 'b' if char == 'б'[0]
		r = 'v' if char == 'в'[0]
		r = 'g' if char == 'г'[0]
		r = 'd' if char == 'д'[0]

		r =  'e' if char == 'е'[0]
		r =  'e' if char == 'ё'[0]
		r =  'zh' if char == 'ж'[0]
		r =  'z' if char == 'з'[0]
		r =  'i' if char == 'и'[0]

		r =  'i''' if char == 'й'[0]
		r =  'k' if char == 'к'[0]
		r =  'l' if char == 'л'[0]
		r =  'm' if char == 'м'[0]
		r =  'n' if char == 'н'[0]

		r =  'o' if char == 'о'[0]
		r =  'p' if char == 'п'[0]
		r =  'r' if char == 'р'[0]
		r =  's' if char == 'с'[0]
		r =  't' if char == 'т'[0]

		r =  'u' if char == 'у'[0]
		r =  'f' if char == 'ф'[0]
		r =  'h' if char == 'х'[0]
		r =  'c' if char == 'ц'[0]
		r =  'ch' if char == 'ч'[0]

		r =  'sh' if char == 'ш'[0]
		r =  'sh''' if char == 'щ'[0]
		r =  '''' if char == 'ъ'[0]
		r =  '''i' if char == 'ы'[0]
		r =  '''' if char == 'ь'[0]

		r =  'e' if char == 'э'[0]
		r =  'yu' if char == 'ю'[0]
		r =  'ya' if char == 'я'[0]

	# big letters

		r = 'A' if char == 'А'[0]
		r = 'B' if char == 'Б'[0]
		r = 'C' if char == 'В'[0]
		r = 'G' if char == 'Г'[0]
		r = 'D' if char == 'Д'[0]

		r =  'E' if char == 'Е'[0]
		r =  'E' if char == 'Ё'[0]
		r =  'Zh' if char == 'Ж'[0]
		r =  'Z' if char == 'З'[0]
		r =  'I' if char == 'И'[0]

		r =  'I''' if char == 'Й'[0]
		r =  'K' if char == 'К'[0]
		r =  'L' if char == 'Л'[0]
		r =  'M' if char == 'М'[0]
		r =  'N' if char == 'Н'[0]

		r =  'O' if char == 'О'[0]
		r =  'P' if char == 'П'[0]
		r =  'R' if char == 'Р'[0]
		r =  'S' if char == 'С'[0]
		r =  'T' if char == 'Т'[0]

		r =  'U' if char == 'У'[0]
		r =  'F' if char == 'Ф'[0]
		r =  'H' if char == 'Х'[0]
		r =  'C' if char == 'Ц'[0]
		r =  'Ch' if char == 'Ч'[0]

		r =  'Sh' if char == 'Ш'[0]
		r =  'Sh''' if char == 'Щ'[0]
		r =  '''' if char == 'Ъ'[0]
		r =  '''I' if char == 'Ы'[0]
		r =  '''' if char == 'Ь'[0]

		r =  'E' if char == 'Э'[0]
		r =  'Yu' if char == 'Ю'[0]
		r =  'Ya' if char == 'Я'[0]

		r =  ' ' if char == ' '[0]
		r =  '.' if char == '.'[0]
		r
	end
public
=begin
	function to_center()
		make from string log output string in center
=end
	def to_center()
		"|"+self.center( $center_value )+"|"
	end
=begin
	function to_left()
		make from string log output string on left
=end
	def to_left()
		"|"+(" "+self).ljust( $center_value )+"|"
	end
=begin
	function to_right()
		make from string log output string on right
=end
	def to_right()
		"|"+(self+" ").rjust( $center_value )+"|"
	end
end

=begin
	function lengthOfVector(x,y)
		input x,y : double value
		output length of vector (x,y)
				calculate length of vector
=end
def lengthOfVector(x,y)
	return ( ((1.0*x)**2)+((1.0*y)**2) )**0.5
end
=begin
	function crossDot(x1,y1,x2,y2,x3,y3,x4,y4)
		input x1,y1,x2,y2,x3,y3,x4,y4 : double value
		output xp,yp dot of line crossing
				calculate cross dot to 2 lines: x1, y1, x2, y2 <-> x3,y3 , x4,y4
=end
def crossDot(x1,y1,x2,y2,x3,y3,x4,y4)
	a1,b1,c1 = makeLineParams(x1,y1,x2,y2)
	a2,b2,c2 = makeLineParams(x3,y3,x4,y4)
	return crossDotByParams(a1,b1,c1,a2,b2,c2)
end
=begin
	function crossDotByParams(a1,b1,c1,a2,b2,c2)
		input a1,b1,c1,a2,b2,c2 : double value
		output xp,yp dot of line crossing
				calculate cross dot to 2 lines: a1,b1,c1 <-> a2,b2,c2
=end
	def crossDotByParams(a1,b1,c1,a2,b2,c2)
	x = (b1*c2-b2*c1)/(a1*b2-a2*b1)
	y = (c1*a2-c2*a1)/(a1*b2-a2*b1)
	return x, y
end
=begin
	function makeLineParams(x1,y1,x2,y2)
		input x1,y1,x2,y2 : double value
		output a,b,c
				calculate a,b,c parameters of line
=end
	def makeLineParams(x1,y1,x2,y2)
	a = 1.0*y2-1.0*y1
	b = 1.0*x1-1.0*x2
	c = -1.0*a*x1-1.0*b*y1
	return a,b,c
end	
