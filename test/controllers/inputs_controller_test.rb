require 'test_helper'

class InputsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @input = inputs(:one)
    @group = groups(:one)
    @controller.session[:group_id] = @group.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inputs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create input" do
    post :create, input: { group_name: @input.group_name, vaccines: @input.vaccines, school_off: @input.school_off, days: @input.days, ads: @input.ads, money_left: @input.money_left, seed: @input.seed }

    assert_response :success
  end

  test "should show input" do
    get :show, id: @input
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @input
    assert_response :success
  end

  # test "should update input" do
  #   patch :update, id: @input, input: { group_name: @input.group_name, vaccines: @input.vaccines, school_off: @input.school_off, days: @input.days+1, ads: @input.ads, money_left: @input.money_left, seed: @input.seed }
  #   assert_redirected_to input_path(assigns(:input))
  # end

  test "should destroy input" do
    assert_difference('Input.count', -1) do
      delete :destroy, id: @input
    end

    assert_redirected_to inputs_path
  end
end
