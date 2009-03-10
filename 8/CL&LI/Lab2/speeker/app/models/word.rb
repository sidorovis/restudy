class Word < ActiveRecord::Base
  belongs_to :word_group
    
  def word_type
    word_group.word_type
  end
  def generate_noun_forms
    word_group.generate_word_forms( content )
  end
  def word_forms
     return generate_noun_forms
  end
  
end
