class SimulationsController < ApplicationController
  before_action :set_simulation, only: [:show, :edit, :update, :destroy]
  helper_method :run_java, :run_sim

  def run_java(input, url)
    @result = system "cd app/assets/sim && java TestJavaApp '#{input}' > output.txt"
    url
  end

  def run_sim(url)
    group_name = current_user.memberships.first.group.name
    @result = system "cd app/assets/sim/test && java -cp .:/usr/share/java/mysql-connector-java-5.1.28.jar Main '#{group_name}' > output.txt &"
    url
  end

  # GET /simulations
  # GET /simulations.json
  def index
    @simulations = Simulation.all
  end

  # GET /simulations/1
  # GET /simulations/1.json
  def show
  end

  # GET /simulations/new
  def new
    @simulation = Simulation.new
  end

  # GET /simulations/1/edit
  def edit
  end

  # POST /simulations
  # POST /simulations.json
  def create
    @simulation = Simulation.new(simulation_params)

    respond_to do |format|
      if @simulation.save
        format.html { redirect_to @simulation, notice: 'Simulation was successfully created.' }
        format.json { render :show, status: :created, location: @simulation }
      else
        format.html { render :new }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /simulations/1
  # PATCH/PUT /simulations/1.json
  def update
    respond_to do |format|
      if @simulation.update(simulation_params)
        format.html { redirect_to @simulation, notice: 'Simulation was successfully updated.' }
        format.json { render :show, status: :ok, location: @simulation }
      else
        format.html { render :edit }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /simulations/1
  # DELETE /simulations/1.json
  def destroy
    @simulation.destroy
    respond_to do |format|
      format.html { redirect_to simulations_url, notice: 'Simulation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_simulation
      @simulation = Simulation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def simulation_params
      params.require(:simulation).permit(:input)
    end
end