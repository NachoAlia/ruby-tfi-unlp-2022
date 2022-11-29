class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end



  #def adminOnly
    #redirect_to '/welcome/index' unless current_user.rol == 2
  #end
end
