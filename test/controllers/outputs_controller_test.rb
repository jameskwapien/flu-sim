require 'test_helper'

class OutputsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @output = outputs(:one)
    @group = groups(:one)
    @controller.session[:group_id] = @group.id
    @input = inputs(:one)
    @controller.session[:input_id] = @input.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outputs)
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
    get :show, id: @output
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
