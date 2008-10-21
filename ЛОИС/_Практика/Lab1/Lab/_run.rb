#!/usr/bin/ruby

require "Lexer"
require "Parser"

l = Lexer.new
p = Parser.new
l.yyin = File.open("input.txt", "r")

p.yydebug = true	## debug
p.yyparse(l)
