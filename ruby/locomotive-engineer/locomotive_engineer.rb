class LocomotiveEngineer
  def self.generate_list_of_wagons(*wagon_ids)
    wagon_ids
  end

  def self.fix_list_of_wagons((wagon_1, wagon_2, wagon_3, *remaining_wagons), missing_wagons)
    [wagon_3, *missing_wagons, *remaining_wagons, wagon_1, wagon_2]
  end

  def self.add_missing_stops(routing_hash, **stops)
    { **routing_hash, stops: stops.values }
  end

  def self.extend_route_information(route, more_route_information)
    { **route, **more_route_information }
  end
end
