require 'test_helper'

class OutputsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @output = outputs(:one)
    @input = inputs(:one)
    @input_two = inputs(:two)
    @group = groups(:one)
    @course = courses(:one)
    @controller.session[:group_id] = @group.id
    @controller.session[:input_id] = @input.id
    @controller.session[:course_id] = @course.id
  end

  # test works perfectly, but calls the actual simulation which throws error message because it doesn't use the test DB
  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:outputs)
  # end

  test "simulation should run and clean up" do
    # controller set up
    old_controller = @controller
    # Inputs controller methods
    # @controller = InputsController.new
    # assert_difference('Input.count', +1) do
    #   post :create, input: { group_name: @input.group_name, vaccines: @input.vaccines, school_off: @input.school_off, days: @input.days, ads: @input.ads, money_left: @input.money_left, seed: @input.seed }
    # end
    # assert_response :redirect
    # Outputs controller methods
    @controller = old_controller
    assert_difference('Output.count', 0) do
      Output.where(:input_id => @input_two.id).destroy_all
    end
    @controller.session[:input_id] = Input.where(:group_name => @input.group_name).first.id
    system "cd test/assets/sim && java -cp .:/usr/share/java/mysql-connector-java.jar Main '#{@input.group_name}'"
    # Inputs controller methods
    @controller = InputsController.new
    assert_difference('Input.count', -1) do
      delete :destroy, id: @input
    end
    assert_response :redirect
    # Outputs controller methods
    # @controller = old_controller
    # assert_difference('Output.count', 0) do
    #   Input.where(:group_name => @input.group_name).destroy_all
    # end
    # Groups controller methods
    @controller = GroupsController.new
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end
    assert_response :redirect
    # Reset to Outputs controller
    @controller = old_controller
    system "cd public/assets/images && rm -rf '#{@group.name}'"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create output" do
    assert_difference('Output.count') do
      post :create, output: { cityID: @output.cityID, day: @output.day, group_name: @output.group_name, immune: @output.immune, pop_age0: @output.pop_age0, pop_age1: @output.pop_age1, pop_age2: @output.pop_age2, population: @output.population, sick: @output.sick, sick_age0: @output.sick_age0, sick_age1: @output.sick_age1, sick_age2: @output.sick_age2, vaccs_left: @output.vaccs_left }
    end

    assert_redirected_to output_path(assigns(:output))
  end

  test "should show output" do
    get :show, id: @output.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @output
    assert_response :success
  end

  test "should update output" do
    patch :update, id: @output, output: { cityID: @output.cityID, day: @output.day, group_name: @output.group_name, immune: @output.immune, pop_age0: @output.pop_age0, pop_age1: @output.pop_age1, pop_age2: @output.pop_age2, population: @output.population, sick: @output.sick, sick_age0: @output.sick_age0, sick_age1: @output.sick_age1, sick_age2: @output.sick_age2, vaccs_left: @output.vaccs_left }
    assert_redirected_to output_path(assigns(:output))
  end

  test "should destroy output" do
    assert_difference('Output.count', -1) do
      delete :destroy, id: @output
    end

    assert_redirected_to outputs_path
  end
end
