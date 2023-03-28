class AssemblyLine

  BASE_HOURLY_RATE = 221

  SUCCESS_RATE_TABLE = {
    (1..4) => 1,
    (5..8) => 0.9,
    (9..9) => 0.8,
    (10..10) => 0.77
  }

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    success_rate = SUCCESS_RATE_TABLE.detect{ |k, v| k.include?(@speed) }.last
    @speed * BASE_HOURLY_RATE * success_rate
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end
end
