module C
    def initialize(a)
	@hello = a
    end
    def to_s
        "multi " + @hello.to_s
    end
end

class A
   attr_writer :hello
end
class B < A
   include C
end

b = B.new(3)
puts b
b.hello = 5
puts b