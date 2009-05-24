class WordFormsController < ApplicationController

  def add_attr
    @word_form = WordForm.find_by_id( session[:word_form_id] )
    attr_id = params[:id].split('_')[1]
    connection = WfAttributesWordForm.new
    connection.word_form_id = @word_form.id
    connection.wf_attribute_id = attr_id
    connection.save
    count_ids
    render :partial => 'show_connected_wf_attributes'
#    render :partial => 'show_other_wf_attributes'
  end
  
  def del_attr
    @word_form = WordForm.find_by_id( session[:word_form_id] )
    attr_id = params[:id].split('_')[1]
    sql = "DELETE FROM wf_attributes_word_forms where wf_attribute_id = #{attr_id} AND word_form_id = #{@word_form.id}"
    WfAttributesWordForm.execute( sql )
    count_ids
    render :partial => 'show_other_wf_attributes'
  end
  # GET /word_forms
  # GET /word_forms.xml
  def index
    @word_forms = WordForm.find(:all,:order=>:word_group_id )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @word_forms }
    end
  end

  # GET /word_forms/1
  # GET /word_forms/1.xml
  def show
    @word_form = WordForm.find( params[:id] )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @word_form }
    end
  end

  # GET /word_forms/new
  # GET /word_forms/new.xml
  def new
    @word_form = WordForm.new
    @word_form.word_group_id = params[:word_group_id]
    @word_groups_map = {}
    for word_group in WordGroup.find(:all)
      @word_groups_map[ word_group.title.to_s + " (" +word_group.template.to_s + ")" ] = word_group.id
    end
    if @word_groups_map.size == 0
      flash[:notice] = 'Add Word Group first!'
      redirect_to(word_groups_path)
    else
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @word_form }
      end
    end
  end
  def count_ids
    all_ids = WfAttribute.find(:all,:order=>:content).map { |i| i.id }
    @my_ids = @word_form.wf_attributes.map { |i| i.wf_attribute_id.to_i }
    @ids = all_ids - @my_ids
  end
  
  # GET /word_forms/1/edit
  def edit
    @word_form = WordForm.find(params[:id])
    count_ids
    session[:word_form_id] = @word_form.id
    @word_groups_map = {}
    for word_group in WordGroup.find(:all)
      @word_groups_map[ word_group.title + "  " + word_group.template ] = word_group.id
    end
  end

  # POST /word_forms
  # POST /word_forms.xml
  def create
    @word_form = WordForm.new(params[:word_form])

    respond_to do |format|
      if @word_form.save
        flash[:notice] = 'WordForm was successfully created.'
        format.html { redirect_to(@word_form) }
        format.xml  { render :xml => @word_form, :status => :created, :location => @word_form }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @word_form.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /word_forms/1
  # PUT /word_forms/1.xml
  def update
    @word_form = WordForm.find(params[:id])

    respond_to do |format|
      if @word_form.update_attributes(params[:word_form])
        flash[:notice] = 'WordForm was successfully updated.'
        format.html { redirect_to(@word_form) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word_form.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /word_forms/1
  # DELETE /word_forms/1.xml
  def destroy
    @word_form = WordForm.find(params[:id])
    @word_form.destroy

    respond_to do |format|
      format.html { redirect_to(word_forms_url) }
      format.xml  { head :ok }
    end
  end
end
