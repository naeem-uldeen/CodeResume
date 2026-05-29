defmodule FileSniffer do

  @file_types [
    {"exe", "application/octet-stream", <<0x7F, 0x45, 0x4C, 0x46>>},
    {"bmp", "image/bmp",                <<0x42, 0x4D>>},
    {"png", "image/png",                <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>},
    {"jpg", "image/jpg",                <<0xFF, 0xD8, 0xFF>>},
    {"gif", "image/gif",                <<0x47, 0x49, 0x46>>}
  ]

  for {ext, mime, file_signature} <- @file_types do
    def type_from_extension(unquote(ext)), do: unquote(mime)
    def type_from_binary(<<unquote(file_signature), _::binary>>), do: unquote(mime)
  end

  def type_from_extension(_), do: nil
  def type_from_binary(_),    do: nil

  def verify(file_binary, extension) do
    case {type_from_extension(extension), type_from_binary(file_binary)} do
      {type, type} when not is_nil(type) -> {:ok, type}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
  
end