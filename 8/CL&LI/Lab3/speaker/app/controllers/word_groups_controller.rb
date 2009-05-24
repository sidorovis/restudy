class WordGroupsController < ApplicationController
  # GET /word_groups
  # GET /word_groups.xml
  def index
    @word_groups = WordGroup.find(:all,:order=>:title)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @word_groups }
    end
  end

  # GET /word_groups/1
  # GET /word_groups/1.xml
  def show
    @word_group = WordGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @word_group }
    end
  end

  # GET /word_groups/new
  # GET /word_groups/new.xml
  def new
    @word_group = WordGroup.new
    @word_types_map = {}
    for word_type in WordType.find(:all)
      @word_types_map[ word_type.title ] = word_type.id
    end
    if ( @word_types_map.size == 0 )
      flash[:notice] = "Add Word Type First"
      redirect_to(word_types_path)
    else
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @word_group }
      end
    end
  end

  # GET /word_groups/1/edit
  def edit
    @word_group = WordGroup.find(params[:id])
    @word_types_map = {}
    for word_type in WordType.find(:all)
      @word_types_map[ word_type.title ] = word_type.id
    end
  end

  # POST /word_groups
  # POST /word_groups.xml
  def create
    @word_group = WordGroup.new(params[:word_group])

    respond_to do |format|
      if @word_group.save
        flash[:notice] = 'WordGroup was successfully created.'
        format.html { redirect_to(@word_group) }
        format.xml  { render :xml => @word_group, :status => :created, :location => @word_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @word_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /word_groups/1
  # PUT /word_groups/1.xml
  def update
    @word_group = WordGroup.find(params[:id])

    respond_to do |format|
      if @word_group.update_attributes(params[:word_group])
        flash[:notice] = 'WordGroup was successfully updated.'
        format.html { redirect_to(@word_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /word_groups/1
  # DELETE /word_groups/1.xml
  def destroy
    @word_group = WordGroup.find(params[:id])
    @word_group.destroy

    respond_to do |format|
      format.html { redirect_to(word_groups_url) }
      format.xml  { head :ok }
    end
  end
end
