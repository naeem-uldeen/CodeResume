defmodule KitchenCalculator do

  # ── Single Source of Truth ───────────────────────────────────────────
  @units_in_ml %{milliliter: 1, cup: 240, fluid_ounce: 30, teaspoon: 5, tablespoon: 15}

  # ── get_volume/1 ─────────────────────────────────────────────────────
  # Generated per-unit so only known units + numbers are accepted.
  # Anything else raises a FunctionClauseError instead of silently
  # matching any 2-tuple.
  for {unit, _ml_per_unit} <- @units_in_ml do
    def get_volume({unquote(unit), volume}) when is_number(volume), do: volume
  end

  # ── to_milliliter/1 ──────────────────────────────────────────────────
  for {unit, ml_per_unit} <- @units_in_ml do
    def to_milliliter({unquote(unit), volume}) when is_number(volume),
      do: {:milliliter, volume * unquote(ml_per_unit)}
  end

  # ── from_milliliter/2 ────────────────────────────────────────────────
  for {unit, ml_per_unit} <- @units_in_ml do
    def from_milliliter({:milliliter, ml}, unquote(unit)) when is_number(ml),
      do: {unquote(unit), ml / unquote(ml_per_unit)}
  end

  # ── convert/2 ────────────────────────────────────────────────────────
  # More efficient: skips the two-function pipeline and directly
  # computes ml → target unit in a single generated clause.
  for {from_unit, from_ml} <- @units_in_ml,
      {to_unit,   to_ml}   <- @units_in_ml do
    def convert({unquote(from_unit), volume}, unquote(to_unit)) when is_number(volume),
      do: {unquote(to_unit), volume * unquote(from_ml) / unquote(to_ml)}
  end

end
