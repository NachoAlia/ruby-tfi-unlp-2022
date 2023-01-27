class Schedule < ApplicationRecord
  belongs_to :sucursal
  validates :day, :start_time, :end_time, :sucursal_id, presence:true
  validates :day, :inclusion => 0..4
  validates :start_time, absence:true unless -> { isValidTime?(:start_time) }
  validates :end_time, absence:true unless -> { isValidTime?(:end_time) }

  def isValidTime?(aTime)
    aTime == "Time" and
    aTime.strftime("%H:%M").between(Time.zone.parse("00:00"), Time.zone.parse("23:59"))
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
