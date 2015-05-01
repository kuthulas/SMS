class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /students
  # GET /students.json
  def index
    if admin_signed_in?
      @filterrific = initialize_filterrific(
        Student,
        params[:filterrific],
        :select_options => {
          sorted_by: Student.options_for_sorted_by,
          with_uin: Student.options_for_uin_select,
          with_fname: Student.options_for_fname_select,
          with_lname: Student.options_for_lname_select
        }
      ) or return
       @students = Student.all.paginate(:page => params[:page])
    end

   
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def import
    begin
       Student.import(params[:file])
       redirect_to students_url, notice: "Students imported."
    rescue ActiveRecord::UnknownAttributeError 
       redirect_to students_url, notice: "Error in imported file!"
    end
  end

  def report
    @students = Student.all.paginate(:page => params[:page])
  end
  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:uin, :fname, :lname, :email)
    end
end
