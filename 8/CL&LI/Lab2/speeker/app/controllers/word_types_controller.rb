class WordTypesController < ApplicationController
  # GET /word_types
  # GET /word_types.xml
  def index
    @word_types = WordType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @word_types }
    end
  end

  # GET /word_types/1
  # GET /word_types/1.xml
  def show
    @word_type = WordType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @word_type }
    end
  end

  # GET /word_types/new
  # GET /word_types/new.xml
  def new
    @word_type = WordType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @word_type }
    end
  end

  # GET /word_types/1/edit
  def edit
    @word_type = WordType.find(params[:id])
  end

  # POST /word_types
  # POST /word_types.xml
  def create
    @word_type = WordType.new(params[:word_type])

    respond_to do |format|
      if @word_type.save
        flash[:notice] = 'WordType was successfully created.'
        format.html { redirect_to(@word_type) }
        format.xml  { render :xml => @word_type, :status => :created, :location => @word_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @word_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /word_types/1
  # PUT /word_types/1.xml
  def update
    @word_type = WordType.find(params[:id])

    respond_to do |format|
      if @word_type.update_attributes(params[:word_type])
        flash[:notice] = 'WordType was successfully updated.'
        format.html { redirect_to(@word_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /word_types/1
  # DELETE /word_types/1.xml
  def destroy
    @word_type = WordType.find(params[:id])
    @word_type.destroy

    respond_to do |format|
      format.html { redirect_to(word_types_url) }
      format.xml  { head :ok }
    end
  end
end
