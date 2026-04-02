module LocomotiveEngineer
  extend self

  def generate_list_of_wagons(*wagon_ids)
    wagon_ids
  end

  def fix_list_of_wagons(wagon_ids, missing_ids)
    wagon_ids.select { |id| id == 1 } +
    missing_ids +
    wagon_ids.slice(3, wagon_ids.size) +
    wagon_ids.slice(0, 2)
  end

  def add_missing_stops(route, **stops)
    route.merge({ stops: stops.values })
  end

  def extend_route_information(route, details)
    route.merge(details)
  end

end
