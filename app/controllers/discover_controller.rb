require_relative '../services/songkick_api'

class DiscoverController < ApplicationController
  def index
    friends = ['rivett']
    user = User.new('rivett', friends)

    @recommendations = user.recommendations
  end
end
