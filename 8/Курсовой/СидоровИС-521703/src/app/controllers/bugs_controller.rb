class BugsController < ApplicationController
	before_filter :project_build_require
	
	def project_build_require
		@project = Project.find(params[:project_id])
		@build = @project.builds.find(params[:build_id])
	end
  # GET /bugs
  # GET /bugs.xml
  def index
	@bugs = @build.bugs.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bugs }
    end
  end

  # GET /bugs/1
  # GET /bugs/1.xml
  def show
    @bug = @build.bugs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bug }
    end
  end

  # GET /bugs/new
  # GET /bugs/new.xml
  def new
    @bug = @build.bugs.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bug }
    end
  end

  # GET /bugs/1/edit
  def edit
    @bug = @build.bugs.find(params[:id])
  end

  # POST /bugs
  # POST /bugs.xml
  def create
    @bug = @build.bugs.new(params[:bug])

    respond_to do |format|
      if @bug.save
        flash[:notice] = 'Ошибка добавлена к рассмотрению.'
        format.html { redirect_to([@project,@build,@bug]) }
        format.xml  { render :xml => @bug, :status => :created, :location => @bug }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bug.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bugs/1
  # PUT /bugs/1.xml
  def update
    @bug = @build.bugs.find(params[:id])

    respond_to do |format|
      if @bug.update_attributes(params[:bug])
        flash[:notice] = 'Данные об ошибке изменены.'
        format.html { redirect_to([@project,@build,@bug]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bug.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.xml
  def destroy
    @bug = @build.bugs.find(params[:id])
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to(project_build_bugs_url(@project,@build)) }
      format.xml  { head :ok }
    end
  end
end
