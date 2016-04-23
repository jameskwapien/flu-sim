class OutputsController < ApplicationController
  before_action :set_output, only: [:show, :edit, :update, :destroy]

  def run_sim
    get_session_group
    group_name = @session_group.name
    @result = system "cd app/assets/sim && java -cp .:/usr/share/java/mysql-connector-java.jar Main '#{group_name}'"
  end

  def get_output_count
    temp_count = 0
    @count = 0
    test_input_id = -1
    Output.belongs_to_group(@output.group_name).each do |o|
      if test_input_id != o.input_id
        test_input_id = o.input_id
        temp_count += 1
      end
      if o.input_id == @output.input_id
        @count = temp_count
      end
    end
  end

  def get_summary_data
    @input = Input.find(@output.input_id)
    @vaccs_money = @input.vaccines * 13
    @vaccs_left = 0
    @population = 0
    @sick = 0
    @immune = 0
    Output.belongs_to_input(@output.input_id).each do |o| 
      @vaccs_left += o.vaccs_left
      @population += o.population
      @sick += o.sick
      @immune += o.immune
    end
  end

  def get_day_span
    @day_span = 0
    Input.belongs_to_group(@output.group_name).each do |i|
      if @output.input_id >= i.id
        @day_span += i.days
      end
    end
  end
      

  # GET /outputs
  # GET /outputs.json
  def index
    # begin simulation
    run_sim
    # Start of data compilation
    get_session_input
    get_session_group
    group_name = @session_group.name
    inputID = @session_input.id
    input = Input.find(inputID)
    @budget_rem = input.money_left
    @budget_vaccs = input.vaccines * 13
    @budget_ads = input.ads
    @population = 0
    @sick = 0
    @immune = 0
    @vaccines_rem = 0
    Output.belongs_to_input(inputID).each do |output|
      @population += output.population
      @sick += output.sick
      @immune += output.immune
      @vaccines_rem += output.vaccs_left
    end
    # end of data compilation
    @outputs = Output.all
  end

  # GET /outputs/1
  # GET /outputs/1.json
  def show
    get_output_count
    get_summary_data
    get_day_span
  end

  # GET /outputs/new
  def new
    @output = Output.new
  end

  # GET /outputs/1/edit
  def edit
  end

  # POST /outputs
  # POST /outputs.json
  def create
    @output = Output.new(output_params)

    respond_to do |format|
      if @output.save
        format.html { redirect_to @output, notice: 'Output was successfully created.' }
        format.json { render :show, status: :created, location: @output }
      else
        format.html { render :new }
        format.json { render json: @output.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outputs/1
  # PATCH/PUT /outputs/1.json
  def update
    respond_to do |format|
      if @output.update(output_params)
        format.html { redirect_to @output, notice: 'Output was successfully updated.' }
        format.json { render :show, status: :ok, location: @output }
      else
        format.html { render :edit }
        format.json { render json: @output.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outputs/1
  # DELETE /outputs/1.json
  def destroy
    @output.destroy
    respond_to do |format|
      format.html { redirect_to outputs_url, notice: 'Output was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_output
      @output = Output.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def output_params
      params.require(:output).permit(:group_name, :money_left, :money_spent_vaccines, :money_spent_ads, :vaccs_left, :population, :sick, :immune, :pop_age0, :sick_age0, :pop_age1, :sick_age1, :pop_age2, :sick_age2, :day, :cityID)
    end
end
