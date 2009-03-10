class WfAttributesController < ApplicationController
  # GET /wf_attributes
  # GET /wf_attributes.xml
  def index
    @wf_attributes = WfAttribute.find(:all,:order=>:content)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wf_attributes }
    end
  end

  # GET /wf_attributes/1
  # GET /wf_attributes/1.xml
  def show
    @wf_attribute = WfAttribute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wf_attribute }
    end
  end

  # GET /wf_attributes/new
  # GET /wf_attributes/new.xml
  def new
    @wf_attribute = WfAttribute.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wf_attribute }
    end
  end

  # GET /wf_attributes/1/edit
  def edit
    @wf_attribute = WfAttribute.find(params[:id])
  end

  # POST /wf_attributes
  # POST /wf_attributes.xml
  def create
    @wf_attribute = WfAttribute.new(params[:wf_attribute])

    respond_to do |format|
      if @wf_attribute.save
        flash[:notice] = 'WfAttribute was successfully created.'
        format.html { redirect_to(@wf_attribute) }
        format.xml  { render :xml => @wf_attribute, :status => :created, :location => @wf_attribute }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wf_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wf_attributes/1
  # PUT /wf_attributes/1.xml
  def update
    @wf_attribute = WfAttribute.find(params[:id])

    respond_to do |format|
      if @wf_attribute.update_attributes(params[:wf_attribute])
        flash[:notice] = 'WfAttribute was successfully updated.'
        format.html { redirect_to(@wf_attribute) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wf_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wf_attributes/1
  # DELETE /wf_attributes/1.xml
  def destroy
    @wf_attribute = WfAttribute.find(params[:id])
    @wf_attribute.destroy

    respond_to do |format|
      format.html { redirect_to(wf_attributes_url) }
      format.xml  { head :ok }
    end
  end
end
