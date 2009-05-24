module Admin
class BuildStatusesController < ApplicationController
  # GET /build_statuses
  # GET /build_statuses.xml
  def index
    @build_statuses = BuildStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @build_statuses }
    end
  end

  # GET /build_statuses/1
  # GET /build_statuses/1.xml
  def show
    @build_status = BuildStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @build_status }
    end
  end

  # GET /build_statuses/new
  # GET /build_statuses/new.xml
  def new
    @build_status = BuildStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @build_status }
    end
  end

  # GET /build_statuses/1/edit
  def edit
    @build_status = BuildStatus.find(params[:id])
  end

  # POST /build_statuses
  # POST /build_statuses.xml
  def create
    @build_status = BuildStatus.new(params[:build_status])

    respond_to do |format|
      if @build_status.save
        flash[:notice] = 'Статус версии успешно создан.'
        format.html { redirect_to(admin_build_status_path(@build_status)) }
        format.xml  { render :xml => @build_status, :status => :created, :location => @build_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @build_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /build_statuses/1
  # PUT /build_statuses/1.xml
  def update
    @build_status = BuildStatus.find(params[:id])

    respond_to do |format|
      if @build_status.update_attributes(params[:build_status])
        flash[:notice] = 'Статус версии успешно изменён.'
        format.html { redirect_to(admin_build_status_path(@build_status)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @build_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /build_statuses/1
  # DELETE /build_statuses/1.xml
  def destroy
    @build_status = BuildStatus.find(params[:id])
    @build_status.destroy

    respond_to do |format|
      format.html { redirect_to(admin_build_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
end
