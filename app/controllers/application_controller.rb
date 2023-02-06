class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  #rescue_from Exception, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def raise_not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end
  
  def not_found
    redirect_to root_url, alert:"This route not exist"
  end

  def error
    redirect_to root_url, alert:"An error ocurred"
  end

  #def adminOnly
    #redirect_to '/welcome/index' unless current_user.rol == 2
  #end
end
