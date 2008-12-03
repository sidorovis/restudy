#!/usr/bin/ruby

require "Lexer"
require "BDParser"
require "RParser"
require "Lois_Algo"

	# максимальное количество дополнительных потоков
$n_max = 4
	# текущее количество дополнительных потоков
$n = 0
	# количество обрабатываемых данных (ранг задачи)
$r = 0

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

puts "BD\n{"
puts " "+bd_parser.equals.join("\n ")
puts " "+bd_parser.facts.join("\n ")
puts " "+bd_parser.rules.join("\n ")
puts "}"

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
puts request_parser.targets.join("\n")
puts
puts 
st = Time.new.to_f
look_for( request_parser.targets )
en = Time.new.to_f
puts en-st
puts
puts " Current rang: "+$r.to_s
