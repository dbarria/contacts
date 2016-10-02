require 'test_helper'
require 'awesome_print'
class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:contact_0)
  end

  test "should get index" do
    get contacts_url, xhr: true
    assert_equal "text/javascript", @response.content_type
    assert_response :success
  end

  test "should get home" do
    get home_contacts_url, xhr: true
    assert_equal "text/html", @response.content_type
    assert_response :success
  end

  test "should show contact" do
    get contact_url(@contact), xhr: true
    assert_equal "text/javascript", @response.content_type
    assert_response :success
  end


  test "should show search" do
    get search_contacts_url(query: "Jordan Wunsch"), xhr: true
    assert_equal "text/javascript", @response.content_type
    assert_response :success
  end

end
