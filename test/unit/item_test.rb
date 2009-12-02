require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  
  def login 
  # we need to log in!
    User.stubs(:authenticate).returns(User.first)
    post :create
  end
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
