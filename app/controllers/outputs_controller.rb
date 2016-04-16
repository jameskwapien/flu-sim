class OutputsController < ApplicationController
  before_action :set_output, only: [:show, :edit, :update, :destroy]
  
  def run_sim
    get_session_group
    group_name = @session_group.name
    @result = system "cd app/assets/sim && java -cp .:/usr/share/java/mysql-connector-java.jar Main '#{group_name}'"
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
    @population = 0
    @sick = 0
    @immune = 0
    @budget_rem = 0
    @vaccines_rem = 0
    @budget_vaccs = 0
    @budget_ads = 0
    Output.belongs_to_input(inputID).each do |output|
      @population += output.population
      @sick += output.sick
      @immune += output.immune
      @vaccines_rem += output.vaccs_left
      @budget_vaccs += output.money_spent_vaccines
    end
    output = Output.belongs_to_input(inputID).last
    @budget_rem = output.money_left
    Input.belongs_to_group(group_name).each do |input|
      if Output.belongs_to_input(input.id).first.present?
        output = Output.belongs_to_input(input.id).first
        @budget_ads += output.money_spent_ads
      end
    end
    # end of data compilation

    @outputs = Output.all
  end

  # GET /outputs/1
  # GET /outputs/1.json
  def show
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
