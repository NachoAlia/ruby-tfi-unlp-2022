class SchedulesController < ApplicationController
  
  def new
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @schedule = Schedule.new
  end

  def create
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @schedule = @sucursal.schedules.build(schedule_params)

    if @schedule.save
      redirect_to sucursal_path(@sucursal), notice:"Schedule was created successfully"
    else
      redirect_to new_sucursal_schedule_path(sucursal_id:@sucursal.id), notice:"Data entered is invalid"
    end
  end

  def edit
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @schedule = Schedule.find_by_id(params[:id])
  end

  def update
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @schedule = Schedule.find_by_id(params[:id])

    if @schedule.update(schedule_params)
        redirect_to sucursal_path(@sucursal), notice:"Schedule was update successfully"
    else
      redirect_to edit_sucursal_schedule_path(id:params[:id],sucursal_id:@sucursal.id), notice:"Data entered is invalid"
    end
  end


  def destroy
    @sucursal = Sucursal.find(params[:sucursal_id])
    @schedule = Schedule.find_by_id(params[:id])

    if @schedule.destroy
      redirect_to sucursal_path(@sucursal), notice: "Schedule was successfully removed", status: :see_other
    else
      redirect_to sucursal_path(@sucursal), notice: "Schedule not exists", status: :unprocessable_entity
    end
  end

  private
  def schedule_params
      params.require(:schedule).permit(:day, :start_time, :end_time)
  end
end
