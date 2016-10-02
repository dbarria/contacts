class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_base_url

  def set_base_url
    @base_url = request.base_url
  end
end
