require_relative '../services/yaypi'

class DiscoverController < ApplicationController
  def index
    friends = ['rivett']
    user = User.new('rivett', friends)

    @recommendations = user.recommendations
  end
end
