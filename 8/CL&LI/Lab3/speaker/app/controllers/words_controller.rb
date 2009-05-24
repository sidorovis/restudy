class WordsController < ApplicationController
  # GET /words
  # GET /words.xml
  def index
    @words = Word.find(:all,:order=>'content')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @words }
    end
  end

  # GET /words/1
  # GET /words/1.xml
  def show
    @word = Word.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @word }
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
  # GET /words/new
  # GET /words/new.xml
  def new
    @word = Word.new
    gen_word_group_map
    if @word_groups_map.size == 0
      flash[:notice] = 'Add Word Group first!'
      redirect_to(word_groups_path)
    else
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @word }
      end
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find(params[:id])
    gen_word_group_map
  end

  # POST /words
  # POST /words.xml
  def create
    @word = Word.new(params[:word])
    gen_word_group_map

    respond_to do |format|
      if @word.save
        flash[:notice] = 'Word was successfully created.'
        format.html { redirect_to(@word) }
        format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.xml
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        flash[:notice] = 'Word was successfully updated.'
        format.html { redirect_to(@word) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.xml
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to(words_url) }
      format.xml  { head :ok }
    end
  end
end
