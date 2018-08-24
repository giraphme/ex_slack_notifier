defmodule ExSlackNotifierTest do
  use ExUnit.Case
  doctest ExSlackNotifier

  test "greets the world" do
    assert ExSlackNotifier.hello() == :world
  end
end
