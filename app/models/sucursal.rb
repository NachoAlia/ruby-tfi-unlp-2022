class Sucursal < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :schedules, dependent: :destroy
  has_many :appointments, dependent: :restrict_with_error

  validates :nombre, presence:true, uniqueness:true
  validates :direccion, :telefono, presence: true
  validates :telefono, :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }

  def sortSchedules
    self.schedules.sort{|a, b| a.day <=> b.day}
  end

  def getSchedulesForAppointmentDate(date)
    date = Date.today unless !date.nil?
    schedule = self.scheduleForOneDate(date)
    return (schedule.nil? or (date <= Date.today) ) ? [] : schedule.generateForAppointment

  end

  def includeTime(aDate, aTime)
    self.getSchedulesForAppointmentDate(aDate).include?(aTime.strftime("%H:%M"))

  end


  private
  def scheduleForOneDate(date)
    self.schedules.select{|sch| sch.containDay(date.wday)}.first
  end

end
