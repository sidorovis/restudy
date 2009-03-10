class GeneralsController < ApplicationController

  def add2error( error_message )
    @exist_error_message = "" unless @exist_error_message
    @exist_error_message += error_message
  end
  def change_forms
    text = params[:text]
    if word_t = Word.find_by_content(text)
      add2error( "such word exist. ( #{word_t.content} is known as #{word_t.word_type.title}) " )
    end
    word_group = WordGroup.find_by_title(params[:word_group])
    if (text.size > 0)
      if word_group.title.include?("Countable Noun") 
        if ( text.size > 0 && text[ text.length - 1].chr == 'y')
          word_group = WordGroup.find_by_title('Countable Noun (sky like)')
        else
          word_group = WordGroup.find_by_title('Countable Noun (apple like)')
        end
      end
      if word_group.title.include?('Regular Verb')
      end
      if word_group.title.include?('Abstract Noun')
      end
      @select_id = word_group.id
      @forms = word_group.generate_word_forms( text )
    else
      @select_id = word_group.id
      @forms = {}
    end
    gen_word_group_map    
    render :partial => 'word_forms'
  end

  def index
    
  end
  
  def new_countable_noun
    @word = Word.new
    @select_id = WordGroup.find_by_title('Countable Noun (apple like)').id
    @forms = {}
    gen_word_group_map
  end
  def new_abstract_noun
    @word = Word.new
    @select_id = WordGroup.find_by_title('Abstract Noun (hate)').id
    @forms = {}
    gen_word_group_map
  end
  def new_regular_verb_e
    @word = Word.new
    @select_id = WordGroup.find_by_title('Regular Verb Group (with \'e\' on end)').id
    gen_word_group_map
    @forms = {}
  end
  def create_word
    @word = Word.new(params[:word])
    
    respond_to do |format|
      if @word.save
        flash[:notice] = 'Word was successfully created.'
        format.html { redirect_to(@word) }
        format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        format.html { redirect_to(:back) }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  def gen_word_group_map
    @word_groups_map = {}
    for word_group in WordGroup.find(:all)
      str = word_group.title + "(" + word_group.template + ") "
      str += "  : " + (word_group.word_forms.map {|i| i.content } ).join(" | ")
      @word_groups_map[ str ] = word_group.id
    end    
  end

end
