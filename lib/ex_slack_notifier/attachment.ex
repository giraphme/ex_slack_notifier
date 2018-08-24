defmodule ExSlackNotifier.Attachment do
  @type t :: %__MODULE__{
          fallback: String.t(),
          color: String.t(),
          pretext: String.t(),
          author_name: String.t(),
          author_link: String.t(),
          author_icon: String.t(),
          title: String.t(),
          title_link: String.t(),
          text: String.t(),
          fields: list(),
          image_url: String.t(),
          thumb_url: String.t(),
          footer: String.t(),
          footer_icon: String.t(),
          ts: integer
        }

  @fields [
    :fallback,
    :color,
    :pretext,
    :author_name,
    :author_link,
    :author_icon,
    :title,
    :title_link,
    :text,
    :fields,
    :image_url,
    :thumb_url,
    :footer,
    :footer_icon,
    :ts
  ]

  defstruct @fields

  def build() do
    %__MODULE__{}
  end

  @spec put(__MODULE__.t(), atom, String.t()) :: __MODULE__.t()
  def put(%__MODULE__{} = this, key, value) when key in @fields do
    %{this | key => value}
  end

  @spec append(__MODULE__.t(), atom, String.t()) :: __MODULE__.t()
  def append(%__MODULE__{} = this, key, value) when key in @fields do
    %{this | key => (Map.get(this, key, []) || []) ++ [value]}
  end

  def to_map(%__MODULE__{} = this) do
    Enum.reduce(@fields, %{}, fn field, acc ->
      value = Map.get(this, field, nil)
      if is_nil(value), do: acc, else: Map.put_new(acc, field, value)
    end)
  end
end
