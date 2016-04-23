require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "comment attributes must not be empty" do
  	comment = Comment.new
  	assert comment.invalid?
  	assert comment.errors[:user_id].any?
  	assert comment.errors[:post_id].any?
  	assert comment.errors[:content].any?
  end
end
