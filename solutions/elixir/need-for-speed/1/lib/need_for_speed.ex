defmodule NeedForSpeed do

  alias NeedForSpeed.Race
  alias NeedForSpeed.RemoteControlCar, as: Car
  import IO, only: [puts: 1]
  import IO.ANSI, except: [default_color: 0]

  @spec print_race(Race.t()) :: :ok
  def print_race(%Race{} = race) do
    puts("🏁 #{race.title} 🏁")
    puts("Status: #{race_status(race)}")
    puts("Distance: #{race.total_distance_in_meters} meters")
    puts("")
    puts("Contestants:")

    race.cars
    |> sort_by_distance()
    |> Enum.with_index(1)
    |> Enum.each(fn {car, index} ->
      puts("")
      print_car(index, car)
    end)

    puts("")
  end

  defp race_status(%Race{cars: cars, total_distance_in_meters: total}) do
    cond do
      cars == [] -> "Not Started"
      Enum.all?(cars, &(&1.distance_driven_in_meters == 0)) -> "Not Started"
      Enum.any?(cars, &(&1.distance_driven_in_meters >= total)) -> "Finished"
      true -> "In Progress"
    end
  end

  defp sort_by_distance(cars), do: Enum.sort_by(cars, & &1.distance_driven_in_meters, :desc)

  defp print_car(index, %Car{} = car) do
    color =
      case car.color do
        :red   -> red()
        :blue  -> cyan()   # test expects cyan for blue
        :green -> green()
      end

    puts("  #{index}. #{color}#{car.nickname}#{default_color()}")
    puts("  Distance: #{car.distance_driven_in_meters} meters")
    puts("  Battery: Battery at #{car.battery_percentage}%")
  end

  def default_color, do: IO.ANSI.default_color()
  
end
