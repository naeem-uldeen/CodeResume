defmodule SpaceAge do

  @earth_year_seconds 365.25 * 24 * 60 * 60

  orbital_periods = %{
    mercury: 0.2408467,
    venus:   0.61519726,
    earth:   1.0,
    mars:    1.8808158,
    jupiter: 11.862615,
    saturn:  29.447498,
    uranus:  84.016846,
    neptune: 164.79132
  }

  @spec age_on(any(), non_neg_integer()) :: {:ok, float()} | {:error, String.t()}
  for {planet, period} <- orbital_periods do
    def age_on(unquote(planet), seconds)
      when is_integer(seconds) and seconds >= 0 do
      {:ok, seconds / @earth_year_seconds / unquote(period)}
    end
  end

  def age_on(_planet, seconds)
    when is_integer(seconds) and seconds >= 0 do
    {:error, "not a planet"}
  end

end
