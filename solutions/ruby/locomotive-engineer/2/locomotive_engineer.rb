module LocomotiveEngineer
  extend self

  def generate_list_of_wagons(*wagon_ids)
    wagon_ids
  end

  def fix_list_of_wagons(wagon_ids, missing_ids)
    first, second, locomotive, *remaining = wagon_ids
    [locomotive, *missing_ids, *remaining, first, second]
  end

   def add_missing_stops(route, **stops)
    {**route, stops: stops.values}
  end

  def extend_route_information(route, details)
    route.merge(details)
  end

end
