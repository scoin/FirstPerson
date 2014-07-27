class UsersController < ApplicationController

  def checkin_points
    @points = []
    user = User.find(session[:user_id]) || User.new
    user.check_ins.each_with_index do |checkin, i|
      @points.push({lat: checkin.location.latitude, lng: checkin.location.longitude})
    end
    render json: @points
  end
end
