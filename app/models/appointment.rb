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
  before_update :can_destroy?, prepend: true

  def can_destroy?
    unless self.state.equal? 0
      self.errors.add(:state, "This appointment has been served")
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
