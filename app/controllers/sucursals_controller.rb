class SucursalsController < ApplicationController
  authorize_resource :class => false
  before_action :authenticate_user!

  def index
    @sucursals = Sucursal.all
  end

  def new
    @sucursal = Sucursal.new
  end

  def create
    @sucursal = Sucursal.new(sucursal_params)

    if @sucursal.save
      redirect_to sucursals_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @sucursal = Sucursal.find(params[:id])
  end

  def update
    @sucursal = Sucursal.find(params[:id])
    if (@sucursal.update(sucursal_params))
      redirect_to sucursals_path, notice:'Branch was updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @sucursal = Sucursal.find(params[:id])
  end

  def destroy
    @sucursal = Sucursal.find(params[:id])

    if @sucursal.destroy
      redirect_to sucursals_path, notice: "Sucursal was successfully removed", status: :see_other
    else
      redirect_to sucursals_path, notice: @sucursal.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  private
  def sucursal_params
    params.require(:sucursal).permit(:nombre, :direccion, :telefono)
  end
end
