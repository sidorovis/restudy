class WordGroup < ActiveRecord::Base
  belongs_to :word_type
  has_many :words
  has_many :word_forms

  include Additions
  
  def generate_forms_for_text( text )
    forms = {}
    deleted_part = template[template.index("}")+1..template.size-1]
    word_root = delete_from_end_of_string( text, deleted_part )
    for word_form in word_forms
      id = []
      word_form.wf_attributes.each { |attr| id << attr.content }
      word_form.content['#{1}'] = word_root
      forms[id] = word_form.content
    end
    forms
  end
  
  def generate_word_forms( text )
    return generate_forms_for_text( text )
  end
end
