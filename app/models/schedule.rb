class Schedule < ApplicationRecord
  belongs_to :sucursal
  validates_uniqueness_of :day, scope: :sucursal_id, message:"Day exist"
  validates :day, :start_time, :end_time, :sucursal_id, presence:true
  validates :day, :inclusion => 0..4
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

  private
  def daysOfTeWeek
    [ "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ]
  end
  def formatTime(aTime)
    aTime.strftime("%H:%M")
  end
end
