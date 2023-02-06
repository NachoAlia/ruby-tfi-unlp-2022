class AppointmentsController < ApplicationController
  authorize_resource :class => false
  before_action :authenticate_user!
  def new
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @appointment = Appointment.new(appointment_params)
  end

  def create
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @appointment = @sucursal.appointments.build(appointment_params)
    @appointment.client_id = current_user.id
    if @appointment.save
      redirect_to new_sucursal_appointment_path(sucursal_id:params[:sucursal_id]), notice:"Appointment created successfully"
    else
      redirect_to new_sucursal_appointment_path(sucursal_id:params[:sucursal_id]), notice:"#{@appointment.errors.full_messages}"
    end
  end

  def edit
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @appointment = Appointment.find_by_id(params[:id])
    @appointment2 = Appointment.new(appointment_params)

  end

  def update
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @appointment = Appointment.find_by_id(params[:id])

    if @appointment.update(appointment_params)
        redirect_to edit_sucursal_appointment_path(@sucursal,@appointment), notice:"appointment was update successfully"
    else
        redirect_to edit_sucursal_appointment_path(@sucursal,@appointment), notice:@appointment.errors.full_messages.inject("Error: "){ |a, e| a << e; a }
    end

  end

  def destroy
    @appointment = Appointment.find_by_id(params[:id])

    if @appointment.destroy
      redirect_to client_appointments_path(id:current_user.id), notice:"Appointment deleted successfully"
    else
      redirect_to client_appointments_path(id:current_user.id), notice:@appointment.errors.full_messages.inject("Error: "){ |a, e| a << e;a }
    end
  end

  def edit_serve
    @sucursal = Sucursal.find_by_id(params[:sucursal_id])
    @appointment = Appointment.find_by_id(params[:id])
  end

  def update_serve
    @appointment = Appointment.find_by_id(params[:id])
    @appointment.comment = params[:comment]
    @appointment.staff_id = current_user.id

    if @appointment.can_serve?
      @appointment.state = 1
      @appointment.save(validate:false)

      redirect_to staff_appointments_path(id:current_user.id), notice:"Appointment served successfully"
    else
      redirect_to staff_appointments_path(id:current_user.id), notice:@appointment.errors.full_messages.inject("Error: "){ |a, e| a << e;a }
    end
  end

  def client_appointments
    @appointments = Appointment.where(client_id: current_user.id)
  end

  def staff_appointments
    @appointments = Appointment.where(sucursal_id: current_user.sucursal_id, state:0)
  end

  private
  def appointment_params
    params.fetch(:appointment,{}).permit(
      :appointment_date,
      :appointment_time,
      :reason
    )
  end

end
