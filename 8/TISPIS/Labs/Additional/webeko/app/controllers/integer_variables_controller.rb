class IntegerVariablesController < ApplicationController
  # GET /integer_variables
  # GET /integer_variables.xml
  def index
    @integer_variables = IntegerVariable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @integer_variables }
    end
  end

  # GET /integer_variables/1
  # GET /integer_variables/1.xml
  def show
    @integer_variable = IntegerVariable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @integer_variable }
    end
  end

  # GET /integer_variables/new
  # GET /integer_variables/new.xml
  def new
    @integer_variable = IntegerVariable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @integer_variable }
    end
  end

  # GET /integer_variables/1/edit
  def edit
    @integer_variable = IntegerVariable.find(params[:id])
  end

  # POST /integer_variables
  # POST /integer_variables.xml
  def create
	@integer_variable = IntegerVariable.new(params[:integer_variable])	
	value = params[:integer_variable][:value]
	if value != value.to_i.to_s
		@integer_variable.errors.add("Can't save integer value with non integer (#{value}) value","")
		render :action => :new
	else
    respond_to do |format|
      if @integer_variable.save
        flash[:notice] = 'IntegerVariable was successfully created.'
        format.html { redirect_to(@integer_variable) }
        format.xml  { render :xml => @integer_variable, :status => :created, :location => @integer_variable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @integer_variable.errors, :status => :unprocessable_entity }
      end
    end
	end
  end

  # PUT /integer_variables/1
  # PUT /integer_variables/1.xml
  def update
    @integer_variable = IntegerVariable.find(params[:id])

    respond_to do |format|
      if @integer_variable.update_attributes(params[:integer_variable])
        flash[:notice] = 'IntegerVariable was successfully updated.'
        format.html { redirect_to(@integer_variable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @integer_variable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /integer_variables/1
  # DELETE /integer_variables/1.xml
  def destroy
    @integer_variable = IntegerVariable.find(params[:id])
    @integer_variable.destroy

    respond_to do |format|
      format.html { redirect_to(integer_variables_url) }
      format.xml  { head :ok }
    end
  end
end
