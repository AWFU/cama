#encoding: utf-8
class Admin::JobsController < AdminController
  authorize_resource
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /admin/jobs
  # GET /admin/jobs.json
  def index

    @job = Job.new
    @jobs = Job.all

  end

  def create

    @job = Job.create()

    respond_to do |format|
      if( @job.errors.any? )
        format.html { redirect_to :back, alert: "新增失敗" }
      else
        format.html { redirect_to edit_admin_job_path(@job) }
      end
    end

  end
  
  def show
  end

  # GET /admin/jobs/1/edit
  def edit
  end

  # PATCH/PUT /admin/jobs/1
  # PATCH/PUT /admin/jobs/1.json
  def update

    respond_to do |format|
      #if @job.update(admin_job_params)
      if @job.update(job_params)
        format.html { redirect_to admin_jobs_path, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :back }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/jobs/1
  # DELETE /admin/jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to admin_jobs_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(:name, :websiteurl, :status)
  end

end
