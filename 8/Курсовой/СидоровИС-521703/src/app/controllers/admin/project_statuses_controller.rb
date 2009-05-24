module Admin
class ProjectStatusesController < ApplicationController
  # GET /project_statuses
  # GET /project_statuses.xml
  def index
    @project_statuses = ProjectStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_statuses }
    end
  end

  # GET /project_statuses/1
  # GET /project_statuses/1.xml
  def show
    @project_status = ProjectStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_status }
    end
  end

  # GET /project_statuses/new
  # GET /project_statuses/new.xml
  def new
    @project_status = ProjectStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_status }
    end
  end

  # GET /project_statuses/1/edit
  def edit
    @project_status = ProjectStatus.find(params[:id])
  end

  # POST /project_statuses
  # POST /project_statuses.xml
  def create
    @project_status = ProjectStatus.new(params[:project_status])

    respond_to do |format|
      if @project_status.save
        flash[:notice] = 'Создан новый статус проектов.'
        format.html { redirect_to(admin_project_status_path @project_status) }
        format.xml  { render :xml => @project_status, :status => :created, :location => @project_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_statuses/1
  # PUT /project_statuses/1.xml
  def update
    @project_status = ProjectStatus.find(params[:id])

    respond_to do |format|
      if @project_status.update_attributes(params[:project_status])
        flash[:notice] = 'Данные о статусе проекта успешно изменены.'
        format.html { redirect_to(admin_project_status_path@project_status) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_statuses/1
  # DELETE /project_statuses/1.xml
  def destroy
    @project_status = ProjectStatus.find(params[:id])
    @project_status.destroy

    respond_to do |format|
      format.html { redirect_to(admin_project_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
end