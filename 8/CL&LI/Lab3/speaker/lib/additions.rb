module Additions
  
########################################################################
### class My Sentence
########################################################################
  class MySentence
	attr_reader :content, :words
	private
	def create_words
		pre_words = @content.split(/[ ,\,,\?,\:,\.,\!,\n,\r]/).find_all { |i| i.length > 0 }
		for word in pre_words		
			content_word_pair = $basises.find { |k| true if (word.include?( k[0] ) && k[1].word_forms.values.include?(word) ) }
			if content_word_pair
				@words <<  MyWord.new(word,content_word_pair[1])
			else
				@words <<  MyWord.new(word)
			end
		end
	end
	public
	def to_s
		@words.join("<br>")+"<br>---<br>"
	end
	public
	def initialize(content)
		@words = []
		@content = content
		create_words
	end
	def key_words( type = nil )
		if type == :what_q_type
			@words.find_all{ |i| true if (!i.word_ref.nil? && i.word_ref.word_group.title != "do group" ) }
		else
			@words.find_all{ |i| true unless i.word_ref.nil? }
		end
	end
	def antikey_words( type = nil )
		if type == :what_q_type
			@words.find_all{ |i| true if (i.word_ref.nil? && i.content.downcase != "what" ) }
		else
			@words.find_all{ |i| true if i.word_ref.nil? }
		end
	end
	def answer_to?( question )
	
		true
#		question.key_words
	end
	def self::define_question_type( sentence )
		first_word = sentence.words[0].content.downcase.to_s
		return :what_q_type if first_word == 'what'
		return :where_q_type if first_word == 'where'
		return :when_q_type if first_word == 'when'
		return :why_q_type if first_word == 'why'
		return :who_q_type if first_word == 'who'
		return :which_q_type if first_word == 'which'
		:other
	end
	def self::www_q_types
		[:what_q_type, :where_q_type, :when_q_type, :why_q_type,
				:who_q_type, :which_q_type]
	end
  end
########################################################################
### class My Word
########################################################################
  class MyWord
	include Comparable
	attr_reader :word, :content, :word_ref
	def initialize(content, word_ref = nil )
		@content = content		
		@word_ref = word_ref
	end
	def to_s
		if @word_ref
			@content+" "+@word_ref.word_forms.find { true }[1].to_s # +"  "+@word_ref.word_group.title+"<br>"
		else
			@content+" !"
		end
	end
	def<=>(other)
		content<=>other.content
	end
  end
########################################################################
### methods
########################################################################

  def delete_from_end_of_string( text, deleted_part )
    i = 0
    u = 0
    while ( i < deleted_part.size ) do
      if ( text[ text.size - 1 - i + u ] == deleted_part[ deleted_part.size-1 - i ] )
        text[ text.size - 1 - i + u ] = ""
        u += 1
      end
      i+=1
    end
    text
  end
  
  def create_basises()
	$basises = {}
	WordGroup.all.each do |wg|
		wg.words.each { |i| $basises[ i.basis( wg ) ] = i }
	end
	$basises = $basises.sort do |l,r|
		ll = l[0]
		rr = r[0]
		if ll.length != rr.length
			rr.length <=> ll.length
		else
			ll <=> rr
		end
	end
  end
  
  def get_answer(text, question)
	create_basises()
	@text_sentencies = []
	for sentence in text.split(/[\.,\!,\?,\n,\r]/).find_all{ |i| i.length > 0 }
		@text_sentencies << MySentence.new( sentence )
	end
	@q_sentence = MySentence.new( question )
# www question type
#	if ( MySentence.www_q_types.include?( type = MySentence.define_question_type( @q_sentence )) )
		type = MySentence.define_question_type( @q_sentence )
		answers = @text_sentencies.map do |sent| 
			label = 0
			key_words = sent.key_words()
			antikey_words = sent.antikey_words()
			for word_in_question in @q_sentence.key_words( type ).map { |i| i.content }
				for word_in_text in key_words
					if word_in_text.word_ref.word_forms.values().include?( word_in_question )
						label += 1
						break
					end
				end
			end
#			puts "-"*70+"\n"+
#				label.to_s+
#				"\n"+(@q_sentence.key_words( type ).map { |i| i.content }).join(", ")+
#				"\n"+(key_words.map{ |i| i.content }).join(", ")+"\n"
#				"-"*70+"\n"
			if ( label > 0 && label > @q_sentence.key_words( type ).size / 2 - 1 )
				counter = label
				label = 0
				for word_in_question in @q_sentence.antikey_words( type ).map { |iu| iu.content }
					for word_in_text in antikey_words
						if word_in_text.content == word_in_question
							label += 1
							break
						end
					end
				end
#				puts "-"*70
#				puts label.to_s+"  '"+(@q_sentence.antikey_words( type ).map { |i| i.content }).join("', '") + "'__\n__'" +
#					(antikey_words.map{ |i| i.content }).join("', '")+"'  "+@q_sentence.antikey_words( type ).size.to_s
#				puts "-"*70
				if ( label > antikey_words.size / 2 - 1 )
					[ sent, counter+label ]
				else
					[ sent, counter ]
				end
			else
				[ sent, label ]
			end
		end
		if (answers.size > 0)
			answers.sort! { |i,u| u[1]<=>i[1] }
#			puts "-"*80
#			puts answers
#			puts "-"*80
			if (answers[0][1] > 0)
				return answers[0][0].content
			else
				return "I can't find such information."
			end
		end
		
  end
  
end
