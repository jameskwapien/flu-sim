class InputsController < ApplicationController
  before_action :set_input, only: [:show, :edit, :update, :destroy]
  helper_method :get_simulation_limit

  def get_simulation_limit
    get_session_group
    days = 0
    Input.belongs_to_group(@session_group.name).each do |i|
      days += i.days
    end
    available = Course.find(@session_group.course_id).days
    @limit = available - days
  end

  # GET /inputs
  # GET /inputs.json
  def index
    @inputs = Input.all
  end

  # GET /inputs/1
  # GET /inputs/1.json
  def show
  end

  # GET /inputs/new
  def new
    get_simulation_limit
    get_session_group
    @group_id = @session_group
    @input = Input.new
  end

  # GET /inputs/1/edit
  def edit
    get_simulation_limit
    get_session_group
  end

  # POST /inputs
  # POST /inputs.json
  def create
    @input = Input.new(input_params)
    get_simulation_limit
    get_session_group
    respond_to do |format|
      if @input.save
        if @session_group
          format.html { redirect_to @session_group, notice: 'Input was successfully created.' }
          format.json { render :show, status: :created, location: @input }
        else
          format.html { redirect_to @input, notice: 'Input was successfully created.' }
          format.json { render :show, status: :created, location: @input }
        end
      else
        format.html { render :new }
        format.json { render json: @input.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inputs/1
  # PATCH/PUT /inputs/1.json
  def update
    get_session_group 
    respond_to do |format|
      if @input.update(input_params)
        if @session_group
          format.html { redirect_to @session_group, notice: 'Input was successfully updated.' }
          format.json { render :show, status: :ok, location: @input }
        else
          format.html { redirect_to @input, notice: 'Input was successfully updated.' }
          format.json { render :show, status: :ok, location: @input }
        end
      else
        format.html { render :edit }
        format.json { render json: @input.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inputs/1
  # DELETE /inputs/1.json
  def destroy
    @input.destroy
    respond_to do |format|
      format.html { redirect_to inputs_url, notice: 'Input was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_input
      @input = Input.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def input_params
      params.require(:input).permit(:group_name, :vaccines, :school_off, :days, :ads, :money_left, :seed)
    end
end
