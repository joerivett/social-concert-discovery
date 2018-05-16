require_relative '../services/yaypi'

class DiscoverController < ApplicationController
  def index
    friends = ['ablinov', 'us_kids_know']
    user = User.new('rivett', friends)

    @recommendations = user.recommendations
  end
end
