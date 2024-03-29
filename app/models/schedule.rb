class Schedule < ApplicationRecord
  belongs_to :sucursal
  validates_uniqueness_of :day, scope: :sucursal_id, message:"Day exist"
  validates :day, :start_time, :end_time, :sucursal_id, presence:true
  validates :day, :inclusion => 1..6
  validate :start_time, :timeValid?

  # def formatTimeValid?(aTime)
  #   aTime == "Time" and
  #   aTime.strftime("%H:%M").between(Time.zone.parse("00:00"), Time.zone.parse("23:59"))
  # end

  def timeValid?
    unless validStart?
      self.errors.add(:start_time, "Invalid time")
    end
  end
  def validStart?
    self.start_time.to_i < self.end_time.to_i
  end

  def dayToStr
    self.daysOfTeWeek[self.day]
  end
  def startToStr
    self.formatTime(self.start_time)
  end
  def endToStr
    self.formatTime(self.end_time)
  end

  def generateForAppointment
    schedules = []
    current = self.start_time
    while current < self.end_time do
      schedules << self.formatTime(current)
      schedules << self.formatTime(current + (60*60/2))
      current = (current + (60*60))
    end
    return schedules
  end

  def containDay(day)
    self.day == day
  end

  private
  def daysOfTeWeek
    [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ]
  end
  def formatTime(aTime)
    aTime.strftime("%H:%M")
  end
end
