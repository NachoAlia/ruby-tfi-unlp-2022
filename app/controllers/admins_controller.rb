class AdminsController < ApplicationController
  authorize_resource :class => false
  before_action :authenticate_user!
  def index
  end
  def users
    @users = User.all.order(created_at: :desc)
  end
  def new_user
    @user = User.new
    @sucursals = Sucursal.all
  end
  def create_user
    @user = User.new(
      email:params[:email],
      password:params[:password],
      password_confirmation:params[:password_confirmation],
      role:params[:role],
      sucursal_id:params[:sucursal]
    )
    if @user.save
      redirect_to admins_users_path, notice:"User created successfully"
    else
      redirect_to admins_new_user_path, alert:@user.errors.full_messages.inject("Error: "){ |a, e| a << "#{e}. ";a }
    end
  end


  def edit_user
    @user = User.find_by_id(params[:id])
    @sucursals = Sucursal.all
  end

  def update_user
    @user = User.find_by_id(params[:id])
    @user.password = params[:password] unless params[:password].blank?
    @user.password_confirmation = params[:password_confirmation] unless params[:password_confirmation].blank?
    if @user.update(
      email:params[:email],
      role:params[:role],
      sucursal_id:params[:sucursal])
      redirect_to admins_users_path, notice:"User updated successfully"
    else
      redirect_to admins_edit_user_path(id:@user.id), alert:@user.errors.full_messages.inject("Error: "){ |a, e| a << "#{e}. ";a }
    end
  end

  def user_destroy
    @user = User.find_by_id(params[:id])
    if @user.destroy
      redirect_to admins_users_path, notice:"User deleted successfully"
    else
      redirect_to admins_users_path, alert:@user.errors.full_messages.inject("Error: "){ |a, e| a << "#{e}. ";a }
    end
  end

  def user_force_destroy
    @user = User.find_by_id(params[:id])
    if @user.role == "client"
      Appointment.where("client_id"==@user.id).delete_all
    else
      Appointment.where("staff_id"==@user.id).delete_all
    end
    if @user.destroy
      redirect_to admins_users_path, notice:"User deleted successfully"
    else
      redirect_to admins_users_path, alert:@user.errors.full_messages.inject("Error: "){ |a, e| a << "#{e}. ";a }
    end
  end


  def clients
    @users = User.where(role:'client')
  end

end
