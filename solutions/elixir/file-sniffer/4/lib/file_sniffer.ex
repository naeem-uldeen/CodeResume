defmodule FileSniffer do

  @file_types [
    %{extension: "exe", mime_type: "application/octet-stream", binary_sig: <<0x7F, 0x45, 0x4C, 0x46>>},
    %{extension: "bmp", mime_type: "image/bmp", binary_sig: <<0x42, 0x4D>>},
    %{extension: "png", mime_type: "image/png", binary_sig: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>},
    %{extension: "jpg", mime_type: "image/jpg", binary_sig: <<0xFF, 0xD8, 0xFF>>},
    %{extension: "gif", mime_type: "image/gif", binary_sig: <<0x47, 0x49, 0x46>>}
  ]

  for %{extension: ext, mime_type: mime} <- @file_types,
    do: def(type_from_extension(unquote(ext)), do: unquote(mime))
  def type_from_extension(_), do: nil

  for %{mime_type: mime, binary_sig: sig} <- @file_types,
    do: def(type_from_binary(<<unquote(sig), _::binary>>), do: unquote(mime))
  def type_from_binary(_), do: nil

  def verify(file_binary, extension)
  for %{extension: ext, mime_type: mime, binary_sig: sig} <- @file_types,
    do: def(verify(<<unquote(sig), _::binary>>, unquote(ext)), do: {:ok, unquote(mime)})
  def verify(_, _), do: {:error, "Warning, file format and file extension do not match."}

end
