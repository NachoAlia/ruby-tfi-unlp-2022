class WelcomeController < ApplicationController
  before_action :authenticate_user!
  authorize_resource :class => false
  def index
  end
  def profile
  end

  def another_profile
    @another_user = User.find_by_id(params[:id])
  end


end
