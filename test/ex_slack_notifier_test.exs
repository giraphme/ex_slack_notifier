defmodule ExSlackNotifierTest do
  use ExUnit.Case
  alias ExSlackNotifier.{Builder, Attachment}

  @attachment %Attachment{color: "good"}

  describe "ExSlackNotifier.build/0" do
    test "It should return a struct of ExSlackNotifier.Builder" do
      assert %Builder{} = ExSlackNotifier.build()
    end
  end

  describe "ExSlackNotifier.put/2" do
    test "It should put a value to struct" do
      tmp = System.get_env("SLACK_API_TOKEN")
      System.put_env("SLACK_API_TOKEN", "mock api token")

      assert %Builder{token: "mock api token"} =
               ExSlackNotifier.build()
               |> ExSlackNotifier.put(:token)

      System.put_env("SLACK_API_TOKEN", tmp)
    end
  end

  describe "ExSlackNotifier.put/3" do
    test "It should put a value to struct" do
      assert %Builder{username: "Hello"} =
               ExSlackNotifier.build()
               |> ExSlackNotifier.put(:username, "Hello")
    end
  end

  describe "ExSlackNotifier.append/3" do
    test "It should append a value to struct field" do
      assert %Builder{attachments: [%Attachment{}]} =
               ExSlackNotifier.build()
               |> ExSlackNotifier.append(:attachments, @attachment)
    end
  end

  describe "ExSlackNotifier.to_map/1" do
    test "It should return a map with :ok" do
      assert %{username: "Hello", attachments: [%{}]} =
               ExSlackNotifier.build()
               |> ExSlackNotifier.put(:username, "Hello")
               |> ExSlackNotifier.append(:attachments, @attachment)
               |> ExSlackNotifier.to_map()
    end
  end

  describe "ExSlackNotifier.to_json/1" do
    test "It should return a json string with :ok" do
      assert "{\"attachments\":[{\"color\":\"good\"}],\"username\":\"Hello\"}" =
               ExSlackNotifier.build()
               |> ExSlackNotifier.put(:username, "Hello")
               |> ExSlackNotifier.append(:attachments, @attachment)
               |> ExSlackNotifier.to_json()
    end
  end

  @channel System.get_env("SLACK_TEST_CHANNEL")
  @tag :skip
  describe "ExSlackNotifier.post_message/3" do
    test "It should send a message and return {:ok, %{}}" do
      assert {:ok, %{}} =
               ExSlackNotifier.build()
               |> ExSlackNotifier.put(:token)
               |> ExSlackNotifier.put(:username, "Hello")
               |> ExSlackNotifier.append(
                 :attachments,
                 Attachment.build()
                 |> Attachment.put(:color, "good")
                 |> Attachment.append(:fields, %{title: "This is a field", value: "the value"})
               )
               |> ExSlackNotifier.post_message(@channel, "Test message from ex_unit")
    end
  end
end
