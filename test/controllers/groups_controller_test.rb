require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @group = groups(:one)
    @course = courses(:one)
    @controller.session[:course_id] = @course.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    system "cd public/assets/images && rm -rf '#{@group.name}'"
    assert_difference('Group.count') do
      post :create, group: { name: @group.name, course_id: @group.course_id }
    end

    assert_response :redirect
    # assert_redirected_to course_path(assigns(@controller.session[:course_id]))
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group
    assert_response :success
  end

  # test "should update group" do
  #   patch :update, id: @group, group: { name: @group.name }
  #   assert_redirected_to group_path(assigns(:group))
  # end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_response :redirect
  end
end
