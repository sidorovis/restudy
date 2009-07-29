class UtfString < String
public
 def each()
  (0..size-1).each { |i| yield(self[i*2,2]) }
 end
 alias old_size size
 def size
  old_size / 2
 end
end

def create_word_hash( word )
 hash = Hash.new()
 word.each { |i| (hash.has_key?(i))?(hash[i] += 1):(hash[i] = 1) }
 hash
end

def deanagramm( anagramma )
 if anagramma.class == String
	anagramma = UtfString.new(anagramma)
 end
 base = IO.readlines("./zdf-utf8.txt")
 base.map! { |i| UtfString.new(i[0,i.size-2]) }
 base.delete_if { |i| i.size != anagramma.size }
 anagramma_hash = create_word_hash anagramma
 base.each do |word| 
	word_hash = create_word_hash(word)
    return word if (word_hash == anagramma_hash)
 end
 return anagramma
end

if (__FILE__ == $0)
	puts deanagramm UtfString.new("балтиац")
	puts deanagramm "лухпо"
end