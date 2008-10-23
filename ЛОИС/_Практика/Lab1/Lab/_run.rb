#!/usr/bin/ruby

require "Lexer"
require "BDParser"
require "RParser"
require "Lois_Algo"

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
$rules = bd_parser.rules

puts "BD\n{"
puts " "+bd_parser.equals.join("\n ")
puts " "+bd_parser.facts.join("\n ")
puts " "+bd_parser.rules.join("\n ")
puts "}"

request_parser = RParser.new
request_parser.init_data

print " ?- "
input_str = gets.chomp
l.yyin = input_str
begin
	request_parser.yyparse(l)
rescue RParser::ParseError
	error = "Wrong targets format"
end
puts request_parser.targets.join("\n")
puts
request_parser.targets.each { |i| look_for( i ) }
