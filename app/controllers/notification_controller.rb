class NotificationController < ApplicationController
  def read
    read = Notification.find params[:id]
  end
  
  def readall
    read = Notification.find params[:user_id]
  end
end
