class WelcomeController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :class => false
  def index
  end
  def profile
  end
end
