defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword()
  @type error :: String.t()
  @type frame_number :: pos_integer()
  @callback init(opts()) :: {:ok, opts()} | {:error, error()}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()
  defmacro __using__(_opts) do
    quote do
      @behaviour DancingDots.Animation
      @impl true
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end
defmodule DancingDots.Flicker do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) do
    if rem(frame_number, 4) == 0 do
      %{dot | opacity: dot.opacity / 2}
    else
      dot
    end
  end
end
defmodule DancingDots.Zoom do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity)
    if is_number(velocity) do
      {:ok, opts}
    else
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end
  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    velocity = Keyword.fetch!(opts, :velocity)
    %{dot | radius: dot.radius + velocity * (frame_number - 1)}
  end
  
end