class StringVariablesController < ApplicationController
  # GET /string_variables
  # GET /string_variables.xml
  def index
    @string_variables = StringVariable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @string_variables }
    end
  end

  # GET /string_variables/1
  # GET /string_variables/1.xml
  def show
    @string_variable = StringVariable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @string_variable }
    end
  end

  # GET /string_variables/new
  # GET /string_variables/new.xml
  def new
    @string_variable = StringVariable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @string_variable }
    end
  end

  # GET /string_variables/1/edit
  def edit
    @string_variable = StringVariable.find(params[:id])
  end

  # POST /string_variables
  # POST /string_variables.xml
  def create
    @string_variable = StringVariable.new(params[:string_variable])

    respond_to do |format|
      if @string_variable.save
        flash[:notice] = 'StringVariable was successfully created.'
        format.html { redirect_to(@string_variable) }
        format.xml  { render :xml => @string_variable, :status => :created, :location => @string_variable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @string_variable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /string_variables/1
  # PUT /string_variables/1.xml
  def update
    @string_variable = StringVariable.find(params[:id])

    respond_to do |format|
      if @string_variable.update_attributes(params[:string_variable])
        flash[:notice] = 'StringVariable was successfully updated.'
        format.html { redirect_to(@string_variable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @string_variable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /string_variables/1
  # DELETE /string_variables/1.xml
  def destroy
    @string_variable = StringVariable.find(params[:id])
    @string_variable.destroy

    respond_to do |format|
      format.html { redirect_to(string_variables_url) }
      format.xml  { head :ok }
    end
  end
end
