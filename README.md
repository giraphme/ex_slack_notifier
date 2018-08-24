# ExSlackNotifier

It's based on [Elixir-Slack](https://github.com/BlakeWilliams/Elixir-Slack).  
Currentry, supported only `chat.postMessage` API.

## Installation

In your `mix.exs`

```elixir
def deps do
  [
    {:ex_slack_notifier, "~> 0.1.0"}
  ]
end
```

In your `config/config.exs`

```elixir
config :ex_slack_notifier, :api_token, "YOUR TOKEN"

# OR

config :ex_slack_notifier, :api_token, {:system, "SLACK_API_TOKEN"}
```

## Usage

```elixir
ExSlackNotifier.build()
|> ExSlackNotifier.put(:token)
|> ExSlackNotifier.put(:username, "Hello")
|> ExSlackNotifier.append(
  :attachments,
  ExSlackNotifier.Attachment.build()
  |> ExSlackNotifier.Attachment.put(:color, "good")
  |> ExSlackNotifier.Attachment.append(:fields, %{title: "This is a field", value: "the value"})
)
|> ExSlackNotifier.post_message("#random", "Test message from ex_unit")
```
