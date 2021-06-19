defmodule CmdTodosTest do
  use ExUnit.Case
  doctest CmdTodos

  test "greets the world" do
    assert CmdTodos.hello() == :world
  end
end
