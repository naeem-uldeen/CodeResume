defmodule PaintByNumber do

  def palette_bit_size(color_count) when color_count <= 1, do: 1
  def palette_bit_size(color_count), do: needed_bits(color_count, 2, 1)

  defp needed_bits(needed, possible, bits) when possible >= needed, do: bits
  defp needed_bits(needed, possible, bits), do: needed_bits(needed, possible * 2, bits + 1)

  def empty_picture(), do: <<>>
  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    pixel_bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(pixel_bit_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    pixel_bit_size = palette_bit_size(color_count)
    case picture do
      <<pixel::size(pixel_bit_size), _rem::bitstring>> -> pixel
      <<>> -> nil
    end
  end

  def drop_first_pixel(picture, color_count) do
    pixel_bit_size = palette_bit_size(color_count)
    case picture do
      <<_pixel::size(pixel_bit_size), rem::bitstring>> -> rem
      <<>> -> <<>>
    end
  end

  def concat_pictures(pic1, pic2), do: <<pic1::bitstring, pic2::bitstring>>
  
end
