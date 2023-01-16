require "test_helper"

class SpendingPlanControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get spending_plan_new_url
    assert_response :success
  end
end
