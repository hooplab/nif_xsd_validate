defmodule NifXsd do
  @typedoc "The opaque resource type that wraps an xmlSchemaPtr."
  @type resource :: any()

  @on_load :load_nifs

  @doc false
  def load_nifs do
    case :erlang.load_nif(
           :filename.join(:code.priv_dir(:nif_xsd_validate), ~c"nif_xsd_validate"),
           0
         ) do
      :ok -> 
        :ok

      {:error, {_, error_text}} -> 
        IO.warn("Error: nif_xsd_validate load failed: #{error_text}")
        :ok
    end
  end

  @doc """
  Takes resource(xmlSchemaPtr) to validate the xml string.
  Use `NifXsd.Schema` to manage resources.
  ## Example
      NifXsd.validate(NifXsd.Schema.get(:someSchemaKey1), "<xml></xml>")
  """
  @spec validate(resource, String.t()) :: :ok | {:error, [String.t()]}
  def validate(_resource, _xml) do
    raise "Error: validate/2 not implemented, load_nif probably failed"
  end

  @doc false
  def load_schema(_path) do
    raise "Error: load_schema/1 not implemented, load_nif probably failed"
  end
end
