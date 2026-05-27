defmodule CaptainsLog do

  @fleet_prefix "NCC-"
  @stardate_format "~.1f"
  @stardate_min 41000.0
  @stardate_max 42000.0
  @planetary_classes [
    "D", "H", "J", "K", "L",
    "M", "N", "R", "T", "Y"
  ]

  def random_planet_class(), do: Enum.random(@planetary_classes)

  def random_ship_registry_number(), do: @fleet_prefix <> "#{Enum.random(1000..9999)}"

  def random_stardate do
    with range <- @stardate_max - @stardate_min, do:
      @stardate_min + :rand.uniform() * range
  end

  def format_stardate(stardate), do: to_string(:io_lib.format(@stardate_format, [stardate]))

end
