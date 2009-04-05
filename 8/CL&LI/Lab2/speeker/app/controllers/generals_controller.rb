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
        if ( text[ text.length - 1].chr == 'y')
          word_group = WordGroup.find_by_title('Countable Noun (sky like)')
        else
          word_group = WordGroup.find_by_title('Countable Noun (apple like)')
        end
      end
      if word_group.title.include?('Regular Verb')
        if ( text[ text.length - 1].chr == 'e')
          word_group = WordGroup.find_by_title('Regular Verb Group (with \'e\' on end)')
        else
          word_group = WordGroup.find_by_title('Regular Verb Group (without \'e\' on end)')
        end
      end
      if word_group.title.include?('Abstract Noun')
      end
      if word_group.title.include?('Simple Equalitation Adjective')
        if (text[ text.length - 1 ].chr == 'e')
          word_group = WordGroup.find_by_title('Simple Equalitation Adjective with e on end')
        else        
          if (text.length >= 4) 
            word_group = WordGroup.find_by_title('Simple Equalitation Adjective')
          else
            word_group = WordGroup.find_by_title('Small Simple Equalitation Adjective')
          end
        end
      end
      if word_group.title.include?('Two Word Adjective')
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
  def calculate_content
    @content, @group_name, @forms = Word.pre_calculate_irregular_content( params )
    respond_to do |format|
      format.js
    end
  end
  def index
    @words = Word.find(:all)
  end
  def new_countable_noun
    new_word_constr('Countable Noun (apple like)')
  end
  def new_abstract_noun
    new_word_constr('Abstract Noun (hate)')
  end
  def new_regular_verb_e
    new_word_constr 'Regular Verb Group (with \'e\' on end)'
  end
  def new_irregular_verb
    new_word_constr nil
    @content = ""
  end
  def new_simple_adjective
    new_word_constr 'Simple Equalitation Adjective'
  end
  def new_2word_adjective
    new_word_constr 'Two Word Adjective'
  end
  def new_preposition
    new_word_constr 'Default Preposition'
  end
  def new_word_constr( title )
    @word = Word.new
    gen_word_group_map
    @select_id = WordGroup.find_by_title( title ).id if title
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
  def create_irregular_verb
    word = Word.build_irregular_verb( params )
    if word.save!
      redirect_to( word )
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
