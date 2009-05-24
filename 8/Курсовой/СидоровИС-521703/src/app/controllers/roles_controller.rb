class RolesController < ApplicationController

  before_filter :project_required

  def project_required
	@project = Project.find(params[:project_id])
  end

  def index
	@roles = @project.roles.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end
  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = @project.roles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = @project.roles.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = @project.roles.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = @project.roles.new(params[:role])

    respond_to do |format|
      if @role.save
        flash[:notice] = 'Новая роль в системе успешно создана.'
        format.html { redirect_to(project_role_path(@project,@role)) }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = @project.roles.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Параметры роли были изменены.'
        format.html { redirect_to(project_role_path(@project,@role)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = @project.roles.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(@project) }
      format.xml  { head :ok }
    end
  end
end