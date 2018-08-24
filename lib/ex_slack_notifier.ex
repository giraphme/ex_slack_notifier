defmodule ExSlackNotifier do
  alias ExSlackNotifier.{Builder, PostMessage}

  @spec build() :: Builder.t()
  def build(), do: %Builder{}

  @spec put(Builder.t(), atom, String.t()) :: Builder.t()
  def put(builder, key), do: Builder.put(builder, key)
  def put(builder, key, value), do: Builder.put(builder, key, value)

  @spec append(Builder.t(), atom, String.t()) :: Builder.t()
  def append(builder, key, value), do: Builder.append(builder, key, value)

  @spec to_json(Builder.t()) :: String.t()
  def to_json(builder), do: Builder.to_json(builder)

  @spec to_map(Builder.t()) :: map()
  def to_map(builder), do: Builder.to_map(builder)

  @spec post_message(Builder.t(), String.t(), String.t()) :: {:ok, any} | {:error, any}
  def post_message(builder, channel, text), do: PostMessage.run(builder, channel, text)
end
