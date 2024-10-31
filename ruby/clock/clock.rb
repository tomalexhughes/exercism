class Clock
  attr_reader :hours, :minutes

  def initialize(hour: 0, minute: 0)
    @minutes = minute % 60
    @hours = (hour + minute.div(60)) % 24
  end

  def to_s
    format('%02d:%02d', hours, minutes)
  end

  def +(other)
    Clock.new(hour: hours + other.hours, minute: minutes + other.minutes)
  end

  def -(other)
    Clock.new(hour: hours - other.hours, minute: minutes - other.minutes)
  end

  def ==(other)
    hours == other.hours && minutes == other.minutes

    # instance_variables.all? do |var|
    #   instance_variable_get(var) == other.instance_variable_get(var)
    # end
  end
end
