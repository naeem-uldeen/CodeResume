defmodule SplitSecondStopwatch do
  @moduledoc """
  A stopwatch that can be used to track lap times.
  """

  @type state :: :ready | :running | :stopped

  defmodule Stopwatch do
    @moduledoc false
    @type t :: %__MODULE__{
            state: SplitSecondStopwatch.state(),
            current_lap: Time.t(),
            previous_laps: [Time.t()]
          }
    defstruct state: :ready, current_lap: ~T[00:00:00], previous_laps: []
  end

  @spec new() :: Stopwatch.t()
  def new(), do: %Stopwatch{}

  @spec state(Stopwatch.t()) :: state()
  def state(stopwatch), do: stopwatch.state

  @spec current_lap(Stopwatch.t()) :: Time.t()
  def current_lap(stopwatch), do: stopwatch.current_lap

  @spec previous_laps(Stopwatch.t()) :: [Time.t()]
  def previous_laps(stopwatch), do: stopwatch.previous_laps

  @spec advance_time(Stopwatch.t(), Time.t()) :: Stopwatch.t()
  def advance_time(%Stopwatch{state: :running} = stopwatch, time), do:
    %{stopwatch | current_lap: add_times(stopwatch.current_lap, time)}
  def advance_time(%Stopwatch{} = stopwatch, _time), do: stopwatch

  @spec total(Stopwatch.t()) :: Time.t()
  def total(stopwatch), do: Enum.reduce(stopwatch.previous_laps, stopwatch.current_lap, &add_times/2)

  @spec start(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def start(%Stopwatch{state: state} = stopwatch) when state in [:ready, :stopped], do: %{stopwatch | state: :running}
  def start(%Stopwatch{state: :running}), do: {:error, "cannot start an already running stopwatch"}

  @spec stop(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def stop(%Stopwatch{state: :running} = stopwatch), do: %{stopwatch | state: :stopped}
  def stop(%Stopwatch{}), do: {:error, "cannot stop a stopwatch that is not running"}

  @spec lap(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def lap(%Stopwatch{state: :running} = stopwatch) do
    %{
      stopwatch
      | previous_laps: stopwatch.previous_laps ++ [stopwatch.current_lap],
        current_lap: ~T[00:00:00]
    }
  end
  def lap(%Stopwatch{}), do: {:error, "cannot lap a stopwatch that is not running"}

  @spec reset(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def reset(%Stopwatch{state: :stopped}), do: %Stopwatch{}
  def reset(%Stopwatch{}), do: {:error, "cannot reset a stopwatch that is not stopped"}

  defp add_times(t1 = %Time{}, %Time{hour: h, minute: m, second: s}), do: Time.add(t1, h * 3600 + m * 60 + s)
end
