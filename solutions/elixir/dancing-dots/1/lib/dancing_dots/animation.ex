defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer
  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number,  opts) :: dot
  
  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def handle_frame(dot, frm, _opts) do
    if Integer.mod(frm, 4) == 0 do
      %DancingDots.Dot{dot | opacity: dot.opacity * 0.5}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def init([velocity: v] = opts) when is_number(v), do: {:ok, opts}
  def init(opts) do 
    v = Keyword.get(opts, :velocity)
    {:error,  "The :velocity option is required, and its value must be a number. Got: #{inspect(v)}"}
  end
  @impl DancingDots.Animation
  def handle_frame(dot, frm, [velocity: v]) do
    %DancingDots.Dot{dot | radius: dot.radius + (frm-1)*v}
  end
end
