class BuildsController < ApplicationController
	before_filter :project_require
	
	def project_require
		@project = Project.find(params[:project_id])
	end
  # GET /builds
  # GET /builds.xml
  def index
	@builds = @project.builds.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @builds }
    end
  end

  # GET /builds/1
  # GET /builds/1.xml
  def show
    @build = @project.builds.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @build }
    end
  end

  # GET /builds/new
  # GET /builds/new.xml
  def new
    @build = @project.builds.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @build }
    end
  end

  # GET /builds/1/edit
  def edit
    @build = @project.builds.find(params[:id])
  end

  # POST /builds
  # POST /builds.xml
  def create
    @build = @project.builds.new(params[:build])

    respond_to do |format|
      if @build.save
        flash[:notice] = 'Версия удачно создана.'
        format.html { redirect_to([@project,@build]) }
        format.xml  { render :xml => @build, :status => :created, :location => @build }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @build.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /builds/1
  # PUT /builds/1.xml
  def update
    @build = @project.builds.find(params[:id])

    respond_to do |format|
      if @build.update_attributes(params[:build])
        flash[:notice] = 'Версия удачно изменена.'
        format.html { redirect_to([@project,@build]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @build.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.xml
  def destroy
    @build = @project.builds.find(params[:id])
    @build.destroy

    respond_to do |format|
      format.html { redirect_to(project_builds_url(@project)) }
      format.xml  { head :ok }
    end
  end
end
