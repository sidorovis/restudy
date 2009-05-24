module Admin
class RightTemplatesController < ApplicationController
  # GET /right_templates
  # GET /right_templates.xml
  before_filter :find_role
  def find_role
	@role = RoleTemplate.find(params[:role_template_id])
  end

  def show
    @right_template = @role.right_templates.find( params[:id] )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @right_template }
    end
  end

  # GET /right_templates/new
  # GET /right_templates/new.xml
  def new
    @right_template = @role.right_templates.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @right_template }
    end
  end

  # GET /right_templates/1/edit
  def edit
    @right_template = @role.right_templates.find(params[:id])
  end

  # POST /right_templates
  # POST /right_templates.xml
  def create
    @right_template = @role.right_templates.new(params[:right_template])

    respond_to do |format|
      if @right_template.save
        flash[:notice] = 'Право было успешно добавлено.'
        format.html { redirect_to(admin_role_template_right_template_path( @role, @right_template)) }
        format.xml  { render :xml => @right_template, :status => :created, :location => @right_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @right_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /right_templates/1
  # PUT /right_templates/1.xml
  def update
    @right_template = @role.right_templates.find(params[:id])

    respond_to do |format|
      if @right_template.update_attributes(params[:right_template])
        flash[:notice] = 'Право было успешно обновлено.'
        format.html { redirect_to(admin_role_template_right_template_path( @role, @right_template)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @right_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /right_templates/1
  # DELETE /right_templates/1.xml
  def destroy
    @right_template = @role.right_templates.find(params[:id])
    @right_template.destroy

    respond_to do |format|
      format.html { redirect_to(admin_role_template_path(@role)) }
      format.xml  { head :ok }
    end
  end
end
end
