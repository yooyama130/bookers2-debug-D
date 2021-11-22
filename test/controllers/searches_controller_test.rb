require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get serach" do
    get searches_serach_url
    assert_response :success
  end

end
