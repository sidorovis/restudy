module Admin
class RoleTemplatesController < ApplicationController
  # GET /role_templates
  # GET /role_templates.xml
  def index
    @role_templates = RoleTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @role_templates }
    end
  end

  # GET /role_templates/1
  # GET /role_templates/1.xml
  def show
    @role_template = RoleTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role_template }
    end
  end

  # GET /role_templates/new
  # GET /role_templates/new.xml
  def new
    @role_template = RoleTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role_template }
    end
  end

  # GET /role_templates/1/edit
  def edit
    @role_template = RoleTemplate.find(params[:id])
  end

  # POST /role_templates
  # POST /role_templates.xml
  def create
    @role_template = RoleTemplate.new(params[:role_template])

    respond_to do |format|
      if @role_template.save
        flash[:notice] = 'Шаблон роли успешно создан.'
        format.html { redirect_to(admin_role_template_path(@role_template)) }
        format.xml  { render :xml => @role_template, :status => :created, :location => @role_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /role_templates/1
  # PUT /role_templates/1.xml
  def update
    @role_template = RoleTemplate.find(params[:id])

    respond_to do |format|
      if @role_template.update_attributes(params[:role_template])
        flash[:notice] = 'Шаблон роли успешно изменён.'
        format.html { redirect_to(admin_role_template_path(@role_template)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /role_templates/1
  # DELETE /role_templates/1.xml
  def destroy
    @role_template = RoleTemplate.find(params[:id])
    @role_template.destroy

    respond_to do |format|
      format.html { redirect_to(admin_role_templates_url) }
      format.xml  { head :ok }
    end
  end
end
end
