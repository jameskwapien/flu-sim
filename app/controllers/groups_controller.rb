class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  helper_method :group_directory, :rem_group_directory

  # Create group specific directories
  def group_directory(group)
    system "cd public/assets/images && mkdir '#{group}'"
  end

  def rem_group_directory(group)
    system "cd public/assets/images && rm -rf '#{group}'"
  end

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    get_session_course
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    get_session_course
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    get_session_course
    respond_to do |format|
      if @group.save
        group_directory(@group.name)
        if @session_course
          format.html { redirect_to @session_course, notice: 'Group was successfully created.' }
        else
          format.html { redirect_to @group, notice: 'Group was successfully created.' }
        end
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end

    group_directory(@group.name)
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    get_session_course
    rem_group_directory(@group.name)
    respond_to do |format|
      if @session_course
        format.html { redirect_to @session_course, notice: 'Group was successfully destroyed.' }
      else
        format.html { redirect_to :back, notice: 'Group was successfully destroyed.' }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:id, :name, :course_id, users_attributes: [:id, :name])
    end
end
