require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @comment = comments(:one)
  end

  # test "should get index" do
  #   get :index
  #   assert_response :redirect
  #   assert_not_nil assigns(:comments)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create comment" do
  #   assert_difference('comments.count') do
  #     post :create, comment: { destroy: @comment.destroy, update: @comment.update }
  #   end

  #   assert_redirected_to post_path(@comment.post_id)
  # end

  # test "should show comment" do
  #   get :show, id: @comment
  #   assert_response :redirect
  # end

  # test "should get edit" do
  #   get :edit, id: @comment
  #   assert_response :redirect
  # end

  # test "should update comment" do
  #   patch :update, id: @comment, comment: { destroy: @comment.destroy, edit: @comment.edit, update: @comment.update }
  #   assert_redirected_to comment_path(assigns(:comment))
  # end

  # test "should destroy comment" do
  #   assert_difference('comments.count', -1) do
  #     delete :destroy, id: @comment
  #   end

  #   assert_redirected_to comments_path
  # end
end
