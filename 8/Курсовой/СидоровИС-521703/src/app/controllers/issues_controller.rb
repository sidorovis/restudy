class IssuesController < ApplicationController
	before_filter :project_require
	
	def project_require
		@project = Project.find(params[:project_id])
	end
  # GET /issues
  # GET /issues.xml
  def index
	@issues = @project.issues.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.xml
  def show
    @issue = @project.issues.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.xml
  def new
    @issue = @project.issues.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = @project.issues.find(params[:id])
  end

  # POST /issues
  # POST /issues.xml
  def create
    @issue = @project.issues.new(params[:issue])

    respond_to do |format|
      if @issue.save
        flash[:notice] = 'Новое требование успешно исправлена'
        format.html { redirect_to([@project,@issue]) }
        format.xml  { render :xml => @issue, :status => :created, :location => @issue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.xml
  def update
    @issue = @project.issues.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        flash[:notice] = 'Новое требование успешно изменена.'
        format.html { redirect_to([@project,@issue]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.xml
  def destroy
    @issue = @project.issues.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to(project_issues_url(@project)) }
      format.xml  { head :ok }
    end
  end
end
