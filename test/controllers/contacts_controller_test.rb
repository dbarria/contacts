require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get contacts_url, xhr: true
    assert_response :success
  end

  test "should get home" do
    get home_contacts_url, xhr: true
    assert_response :success
  end

  test "should show contact" do
    get contact_url(@contact), xhr: true
    assert_response :success
  end


  test "should show search" do
    get search_contacts_url(query: "smith"), xhr: true
    assert_response :success
  end

end
