#!/usr/bin/ruby

require "Lexer"
require "BDParser"
require "RParser"
require "Lois_Algo"

	# количество обрабатываемых данных (ранг задачи)
$r = 0
	# отоброжать ли считанные данные
$show_bd = false
	# отоброжать ли результаты вычисления
$show_result = false

$sleep_size = 0

$n_min_min = 0
$n_max_max = 19

l = Lexer.new
l.yyin = File.open("input.txt", "r")

bd_parser = BDParser.new
bd_parser.init_data

begin
	bd_parser.yyparse(l)
rescue BDParser::ParseError
	puts "Wrong BD format"
	exit 1
end

$equals = bd_parser.equals
$facts = bd_parser.facts
	temp = Array.new
	$facts.each { |i| temp.push( BDParser::PredicateTerm.new(i.name.clone,i.params.clone) ) }
	$facts = temp.clone
$rules = bd_parser.rules

if $show_bd
	puts "BD\n{"
	puts " "+bd_parser.equals.join("\n ")
	puts " "+bd_parser.facts.join("\n ")
	puts " "+bd_parser.rules.join("\n ")
	puts "}"
end 
request_parser = RParser.new
request_parser.init_data

#print " ?- "
#input_str = gets.chomp
l.yyin = File.open("question.txt", "r") # input_str
begin
	request_parser.yyparse(l)
rescue RParser::ParseError
	error = "Wrong targets format"
end

if $show_bd
puts request_parser.targets.join("\n")
	puts
	puts 
end         
for n in $n_min_min..$n_max_max
	$r = 0
	$n = 0
	$n_max = n
	$t = 0
	st = Time.new.to_f
	look_for( request_parser.targets )
	en = Time.new.to_f
	print "\tРaнг: \t"+$r.to_s
	print "\tПотоков: \t"+($n_max+1).to_s
	print "\tВремя решения: \t"+(en-st).to_s
	puts "\t #{$t}"
end