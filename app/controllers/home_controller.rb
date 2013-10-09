class HomeController < ApplicationController

  def feed
    redirect_to "http://#{ENV['WORDPRESS_SITE_ID']}/feed"
  end
end