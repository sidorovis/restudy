class TasksController < ApplicationController
	before_filter :project_require
	
	def project_require
		@project = Project.find(params[:project_id])
	end
  # GET /tasks
  # GET /tasks.xml
  def index
	@tasks = @project.tasks.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = @project.tasks.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = @project.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = @project.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Задача была успешно создана.'
        format.html { redirect_to([@project,@task]) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = @project.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Данные задачи были обновлены.'
        format.html { redirect_to([@project,@task]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = @project.tasks.find(params[:id])

    @task.destroy
    respond_to do |format|
      format.html { redirect_to(project_tasks_url(@project)) }
      format.xml  { head :ok }
    end
  end
end
