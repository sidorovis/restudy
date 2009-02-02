#!/usr/bin/ruby

$window_size = 70

$print_real_output = true
$print_debug = false

require "classes"
require "input"
require "Array2"

def counting()
	$label = true
	while $label
		additional_facts = []
		$label = false
		for rule in $rules
			for fact in $facts
				if (rule.factFit?( fact ))
#					puts fact
					new_fact = rule.generateFact( fact )
					puts " Test: "+new_fact.to_s
					ex_fact = $facts.find { |i_fact| true if i_fact == new_fact }
					(ex_fact = additional_facts.find { |i_fact| true if i_fact == new_fact }) unless ex_fact
					unless ex_fact
						$label = true
						additional_facts << new_fact
					end
				end

			end
		end
		additional_facts.each { |fact| $facts << fact }
	end
end

$facts = []
$rules = []


puts "+- BD "+("-"*($window_size-5))+"+" if $print_real_output || $print_debug
for predicate, equal in $input_facts
	$facts << Fact.new(predicate, equal)
end
puts $facts
for rule in $input_rules
	$rules << Rule.new( rule[0], rule[1] )
end
puts $rules
puts "+"+"-"*$window_size+"+" if $print_real_output || $print_debug
if $facts.size >= 2
	counting()
end
puts "+- Answer "+("-"*($window_size-9))+"+" if $print_real_output
puts $facts if $print_real_output
puts "+"+"-"*$window_size+"+" if $print_real_output
