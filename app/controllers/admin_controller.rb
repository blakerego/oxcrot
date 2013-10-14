class AdminController < ApplicationController

  before_filter :authenticate


  def index

  end

  def clear_cache
    Rails.cache.clear()
    @notice = 'Cache has been cleared.'
    render 'index'
  end

  protected

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["HAPPILY_ADRIFT_ADMIN_USER"] && password == ENV["HAPPILY_ADRIFT_PASSWORD"]
      end
    end
end