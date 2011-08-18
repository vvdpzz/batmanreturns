class PusherController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id,
        :user_info => {
           :name => current_user.username
        }
      })
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end
