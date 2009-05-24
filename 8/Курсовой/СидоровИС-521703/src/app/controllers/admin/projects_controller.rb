module Admin
class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @all_projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
		 role_template = RoleTemplate.find(1)
		 @role = Role.new
		@role.title = role_template.title
		@role.description = role_template.description
		 @role.role_template = role_template
		 @role.user = current_user
		 @role.project = @project
		if @role.save
			flash[:notice] = 'Проект успешно создан.'
			format.html { redirect_to(admin_project_path(@project)) }
			format.xml  { render :xml => @project, :status => :created, :location => @project }
		else
			flash[:error] = "Не могу сохранить роль"
			format.html { render :action => "new" }
			format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
		end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
	
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Проект успешно изменён.'
        format.html { redirect_to(admin_project_path(@project)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(admin_projects_path) }
      format.xml  { head :ok }
    end
  end
end
end