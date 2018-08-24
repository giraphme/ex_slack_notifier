defmodule ExSlackNotifier.PostMessage do
  alias ExSlackNotifier.Builder

  @spec run(Builder.t(), String.t(), String.t()) :: {:ok, any} | {:error, any}
  def run(%Builder{} = builder, channel, text) do
    Slack.Web.Chat.post_message(
      channel,
      text,
      builder
      |> Builder.to_map()
      |> tweak_attachments()
    )
    |> case do
      %{"ok" => true} = response -> {:ok, response}
      response -> {:error, response}
    end
  end

  defp tweak_attachments(%{attachments: attachments} = opts) do
    # https://github.com/BlakeWilliams/Elixir-Slack expect a nested array.
    %{opts | attachments: [Jason.encode!(attachments)]}
  end

  defp tweak_attachments(opts), do: opts
end
