defmodule ExSlackNotifier.Builder do
  alias ExSlackNotifier.Attachment

  @type t :: %__MODULE__{
          as_user: boolean | nil,
          attachments: list() | nil,
          icon_emoji: String.t() | nil,
          icon_url: String.t() | nil,
          link_names: boolean | nil,
          mrkdwn: boolean | nil,
          parse: String.t() | nil,
          reply_broadcast: boolean | nil,
          thread_ts: float | nil,
          unfurl_links: boolean | nil,
          unfurl_media: boolean | nil,
          username: String.t() | nil,
          token: String.t() | nil
        }

  @fields [
    :as_user,
    :attachments,
    :icon_emoji,
    :icon_url,
    :link_names,
    :mrkdwn,
    :parse,
    :reply_broadcast,
    :thread_ts,
    :unfurl_links,
    :unfurl_media,
    :username,
    :token
  ]

  defstruct @fields

  @spec put(__MODULE__.t(), atom, String.t()) :: __MODULE__.t()
  def put(%__MODULE__{} = this, key, value) when key in @fields do
    %{this | key => value}
  end

  @default_token_env "SLACK_API_TOKEN"
  def put(%__MODULE__{} = this, :token) do
    case Application.get_env(:ex_slack_notifier, :api_token) do
      {:system, env} -> %{this | token: System.get_env(env)}
      token when is_binary(token) -> %{this | token: token}
      nil -> %{this | token: System.get_env(@default_token_env)}
    end
  end

  @spec append(__MODULE__.t(), atom, String.t()) :: __MODULE__.t()
  def append(%__MODULE__{} = this, key, value) when key in @fields do
    %{this | key => (Map.get(this, key, []) || []) ++ [value]}
  end

  @spec to_json(__MODULE__.t()) :: String.t()
  def to_json(%__MODULE__{} = this) do
    this
    |> to_map()
    |> Jason.encode!()
  end

  @spec to_map(__MODULE__.t()) :: map()
  def to_map(%__MODULE__{} = this) do
    Enum.reduce(@fields, %{}, fn
      :attachments, acc ->
        case this.attachments do
          nil ->
            acc

          attachments when is_list(attachments) ->
            Map.put_new(acc, :attachments, Enum.map(attachments, &Attachment.to_map/1))
        end

      field, acc ->
        value = Map.get(this, field, nil)
        if is_nil(value), do: acc, else: Map.put_new(acc, field, value)
    end)
  end
end
