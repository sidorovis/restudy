class Word < ActiveRecord::Base
  belongs_to :word_group
    
  def word_type
    word_group.word_type
  end
  def basis(finish_wg)
	finish = String.new(finish_wg.template)
	finish['#{1}'] = ""
	content_c = String.new(content)
	content_c[finish] = ""
	content_c
  end
  def generate_noun_forms
    word_group.generate_word_forms( content )
  end
  def word_forms
     return generate_noun_forms
  end
  def self.pre_calculate_irregular_content( params )
      def self.find_same( forms )
        same = forms[0].clone
        for form in forms
          unless form.empty?
            i = 0
            while i < form.size && i < same.size && form[i] == same[i] do
              i += 1
            end
            same = same[0...i]
          end
        end
        same
      end
      def self.change_same( forms, same )
        for form in forms
          form[same] = '#{1}' if form.include?( same )
        end
        forms
      end
      f1 = params[:infinitive].clone
      f2 = params[:past].clone
      f3 = params[:imperative].clone
      f4 = params[:present_participle].clone
      f5 = params[:past_participle].clone
      group_name = f1.clone
      same = find_same( [ f1, f2 , f3 , f4 , f5 ])
      forms = change_same( [ f1 , f2 , f3 , f4 , f5 ] , same )
      content = forms.join "<br/>"
      group_name[ same ] = '#{1}'
      return content, group_name, forms
  end
  
  def self.build_irregular_verb( params )
    content, group_name, forms = pre_calculate_irregular_content( params )
    word_group = WordGroup.new
    word_group.template = forms[ 0 ].clone
    word_group.title = params[:infinitive].to_s + " group"
    word_group.word_type_id = WordType.find_by_title("verb").id
    word = Word.new
    word.content = params[:infinitive]
    word.word_group = word_group    
    for index in [ 0 , 1 , 2 , 3 , 4 ]
      word_form = WordForm.new
      word_form.content = forms[ index ]
      word_group.word_forms << word_form.clone
    end
    word_group.word_forms[ 0 ].wf_attributes << WfAttribute.find_by_content('Infinitive')
    word_group.word_forms[ 1 ].wf_attributes << WfAttribute.find_by_content('Past')
    word_group.word_forms[ 2 ].wf_attributes << WfAttribute.find_by_content('Imperative')
    word_group.word_forms[ 3 ].wf_attributes << WfAttribute.find_by_content('Present Continuous')
    word_group.word_forms[ 3 ].wf_attributes << WfAttribute.find_by_content('Active voice')

    word_group.word_forms << word_group.word_forms[ 4 ].clone
    
    word_group.word_forms[ 4 ].content = "have "+word_group.word_forms[ 4 ].content
    word_group.word_forms[ 4 ].wf_attributes << WfAttribute.find_by_content('Present Perfect')    
    word_group.word_forms[ 4 ].wf_attributes << WfAttribute.find_by_content('Active voice')
    word_group.word_forms[ 4 ].wf_attributes << WfAttribute.find_by_content('I We You They')
    word_group.word_forms[ 5 ].content = "has "+word_group.word_forms[ 5 ].content
    word_group.word_forms[ 5 ].wf_attributes << WfAttribute.find_by_content('Present Perfect')    
    word_group.word_forms[ 5 ].wf_attributes << WfAttribute.find_by_content('Active voice')
    word_group.word_forms[ 5 ].wf_attributes << WfAttribute.find_by_content('He She It')

    word
  end
  
end
