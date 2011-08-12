class ApplicationController < ActionController::Base
  include SentientController
  before_filter :authenticate_user!
  protect_from_forgery
end
