class Appointment < ApplicationRecord

  belongs_to :client, class_name: "User", foreign_key:"client_id"
  belongs_to :staff, class_name: "User", foreign_key:"staff_id", optional:true
  belongs_to :sucursal

  validates_uniqueness_of :sucursal_id,
    scope:[:appointment_date, :appointment_time],
    message:"Appointment exist"
  validates_uniqueness_of :sucursal_id,
    scope:[:appointment_date, :client_id],
    message:"You already have an appointment today"

  validates :appointment_date,
            :appointment_time,
            :client_id,
            :sucursal_id,
            :reason,
            presence:true

  validate :appointment_time, :timeForAppointmentValid?

  before_destroy :can_destroy?, prepend: true
  validate :state, :can_destroy?, on: :update


  def can_serve?
    @aux = Appointment.find_by_id(self.id)
    if self.comment.blank? or !@aux.staff_id.blank? or !@aux.state.equal?0 #or @app.state.equal?1)
        self.errors.add(:base, "Error on served ")
        return false
    end
    return true
  end

  def can_destroy?
    unless self.state.equal? 0
      self.errors.add(:base, "This appointment has been served")
      throw :abort
    end
  end

  def timeForAppointmentValid?
    unless validTime?
      self.errors.add(:appointment_time, "Invalid time")
    end
  end

  def validTime?
    Sucursal.find_by_id(self.sucursal_id).includeTime(self.appointment_date,self.appointment_time)
  end

  def state_to_s
    if ( self.state.equal?0 )
      return "pending"
    else
      return "served"
    end
  end


end
